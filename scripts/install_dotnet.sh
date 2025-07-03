apt-get update
apt-get install -y wget apt-transport-https software-properties-common

wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb

apt-get update
apt-get install -y dotnet-sdk-8.0
