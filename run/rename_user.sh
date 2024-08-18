echo "Enter the new username: "
read newUsername
echo "New username was set to $newUsername"
echo

echo "Enter the username that should be changed: "
read oldUsername
echo "To be changed username was set to $oldUsername"
echo 

echo "Username $oldUsername will be changed to $newUsername"
echo "Groupname $oldUsername will be changed to $newUsername"
echo "Homedirectory /home/$oldUsername will be changed to /home/$newUsername"
echo

sudo usermod -l $newUsername $oldUsername
sudo groupmod -n $newUsername $oldUsername
sudo usermod -d /home/$newUsername -m $newUsername

echo "Changes successfully applied"