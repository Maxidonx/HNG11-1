# This is a bash script.
This bash script called ```create_users.sh``` is solely for the purpose of creating users and assigning groups and roles. It reads a text  file containing employee’s usernames and group names, where each line is formatted as ```user;groups```. It save the time and efforets to adding users to groups on ubuntu OS.

## How to use

- clone this reposistory
- create a text file, at the root of the directory example;
```
employee.txt
```
- Add users to ```employee.txt``` and there respective groups:
```
miki; sudo,dev
lihgt; home, dev, www-data
```
## How to add users in groups in an Ubuntu system
- open your terminal and make sure you are in the cloned repository
copy this command
```
sudo bash create_users.sh <example.txt>
```
- it will add the user to the groups, give the user a 12 character password.
```
User amu created.
Password set for user amu.
User amu added to groups: sudo,dev,www-data
User amina created.
Password set for user amina.
User amina added to groups: sudo,dev,www-data
```
- If the user exist it will send a message that user already exists, it wont create the user except if a new group is add.
```
User miki already exists.
User lihgt already exists.
User creation process completed.
```

## To confirm results
- Use to see the users logs: This command will list the entire log
```
sudo cat /var/log/user_management.log
```
- To geneated passwords for each user: use this command
```
sudo cat /var/secure/user_passwords.txt
```
- To delete a user rund this command
```
sudo deluser <username>
```
- To retrive users from the dtatabase, run this command.
```
getent passwd
```

