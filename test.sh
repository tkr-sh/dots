distro="$1"


echo "Copying the directory..."
cp -r dots "test/$distro" || exit

echo "Copying the install.sh file..."
cp install.sh "test/$distro" || exit

echo "Changing of directory..."
cd "test/$distro" || exit

echo "Building the image..."
docker build -t "$distro:latest" "." || exit

echo "Removing the temp directory..."
rm -rf dots
rm install.sh
