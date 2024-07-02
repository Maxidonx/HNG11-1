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
2024-07-02 15:30:35 - User mad created.
2024-07-02 15:30:35 - Password set for user mad.
2024-07-02 15:30:35 - User mad added to groups: sudo,dev
2024-07-02 15:30:35 - User creation process completed.
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
## Conclusion 
Managing users on a Linux system can be a repetitive task, especially when onboarding multiple new employees. Automating this process can save time and reduce the risk of human error. In this guide, we'll create a bash script that reads user information from a text file, makes the users, assigns them to groups, sets up their home directories, and generates passwords. We'll also ensure all actions are logged and passwords securely stored.
