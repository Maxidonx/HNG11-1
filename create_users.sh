#!/bin/bash

LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"
USER_FILE="$1"

# Check if the user file is provided
if [ -z "$USER_FILE" ]; then
    echo "Usage: $0 <name-of-text-file>"
    exit 1
fi

# Create necessary directories
mkdir -p /var/secure
touch "$LOG_FILE"
touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

# Ensure the file ends with a newline
echo "" >> "$USER_FILE"

while IFS=';' read -r username groups; do
    # Remove whitespace
    username=$(echo "$username" | xargs)
    groups=$(echo "$groups" | xargs)

    # Skip empty lines and invalid usernames
    if [ -z "$username" ]; then
        continue
    fi

    # Create user and personal group
    if id "$username" &>/dev/null; then
        echo "User $username already exists." | tee -a "$LOG_FILE"
    else
        useradd -m -s /bin/bash -G "$groups" "$username"
        if [ $? -eq 0 ]; then
            echo "User $username created." | tee -a "$LOG_FILE"
        
            # Create a random password
            password=$(openssl rand -base64 12)
            echo "$username:$password" | chpasswd
            if [ $? -eq 0 ]; then
                echo "$username,$password" >> "$PASSWORD_FILE"
                echo "Password set for user $username." | tee -a "$LOG_FILE"
            else
                echo "Failed to set password for user $username." | tee -a "$LOG_FILE"
            fi

            # Set up home directory permissions
            chown "$username:$username" "/home/$username"
            chmod 700 "/home/$username"

            echo "User $username added to groups: $groups" | tee -a "$LOG_FILE"
        else
            echo "Failed to create user $username." | tee -a "$LOG_FILE"
        fi
    fi
done < "$USER_FILE"

echo "User creation process completed." | tee -a "$LOG_FILE"
