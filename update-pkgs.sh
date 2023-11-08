#!/bin/bash
# update-pkgs.sh - Update the AUR packages in the Tao Linux package database and push changes to Git

# Check if the user is in the same working directory as the script
script_path=$(dirname "$(realpath -s "$0")")
if [ "$(pwd)" != "$script_path" ]; then
  echo "Please run the script from the same directory as the script."
  exit 1
fi

# Check if the "x86_64" folder exists in the working directory
if [ ! -d "x86_64" ]; then
  echo "The 'x86_64' folder does not exist in the working directory."
  exit 1
fi

# Check if Clean Chroot Manager is installed and configured
if ! command -v ccm &> /dev/null; then
  echo "Clean Chroot Manager is not installed."
  exit 1
fi

if [ ! -f ~/.config/clean-chroot-manager.conf ]; then
  echo "Clean Chroot Manager is not configured."
  exit 1
fi

# Define package names to exclude from building
exclusions=("lsb-release-tao" "bsp-layout" "python-istao")
# Initialize an array to store package names
packages=()

# Iterate through files in the x86_64 directory
for file in x86_64/*
do
    # Check if the file has the .pkg.tar.zst extension
    if [[ "$file" =~ \.pkg\.tar\.zst$ ]]; then
        # Get the package name from the file using pacman
        package_name="$(pacman -Qqp $file)"
        if [[ ! " ${exclusions[@]} " =~ " $package_name " ]]; then
            # Add the package name to the array
            packages+=("$package_name")
        fi
    fi
done

# Remove duplicate package names, sort, and store in the packages array
packages=($(echo "${packages[@]}" | tr ' ' '\n' | sort -u))

echo "The following packages will be built:"
# Print the package names to be built
for i in "${packages[@]}"
do
    echo "$i"
done

# Ask for user confirmation to proceed with building
read -p "Proceed with build? [Y/n] " response
response=${response:-Y}

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Building packages."
    sudo ccm c
    # Loop through packages and build them
    for pkg_to_build in "${packages[@]}"
    do
        git clone https://aur.archlinux.org/${pkg_to_build}.git
        cd "$pkg_to_build"
        sudo ccm s
        cp *.pkg.tar.zst ../x86_64/
        cd ..
        rm -rf "$pkg_to_build"
    done
    sudo ccm n
else
	echo "Exiting."
	exit 0
fi

# Delete Tao-Repo.db and Tao-Repo.files if they exist in x86_64
if [ -f "x86_64/Tao-Repo.db" ]; then
  rm "x86_64/Tao-Repo.db"
fi
if [ -f "x86_64/Tao-Repo.files" ]; then
  rm "x86_64/Tao-Repo.files"
fi

# Change directory to x86_64
cd "x86_64" || exit 1

# Run the command to create Tao-Repo.db.tar.gz and Tao-Repo.files.tar.gz
repo-add ./Tao-Repo.db.tar.gz ./*.pkg.tar.zst

# Delete symlinks Tao-Repo.db and Tao-Repo.files
rm Tao-Repo.db Tao-Repo.files

# Rename .db.tar.gz and .files.tar.gz to remove .tar.gz suffix
mv Tao-Repo.db.tar.gz Tao-Repo.db
mv Tao-Repo.files.tar.gz Tao-Repo.files

# Change back to the previous directory
cd - || exit 1

# Show contents of the x86_64 directory
echo "Contents of the x86_64 directory:"
if command -v lsd &>/dev/null; then
    lsd x86_64/
else
    ls x86_64/
fi

# Offer to push changes to Git
read -r -p "Do you want to push the changes to Git? (yes/no): " choice
if [ "$choice" != "yes" ]; then
  echo "Exiting without pushing to Git."
  exit 0
fi

# Push changes to Git
git add -A
read -r -p "Enter the commit message: " commit_message
git commit -m "$commit_message"
git push

echo "Update process completed successfully."
