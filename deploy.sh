#! /bin/bash

sudo apt-get update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Install Go language
sudo apt-get -y upgrade
cd /tmp
wget https://dl.google.com/go/go1.11.linux-amd64.tar.gz
sudo tar -xvf go1.11.linux-amd64.tar.gz
sudo mv go /usr/local

# Set up Go environment
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Update current shell session
source ~/.profile
# sudo apt install golang-go -y

# Verify Go installation
sudo apt-get install -y golang
go version

# Get & Run the Application
mkdir go && cd go && mkdir bin
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

go get -d github.com/Servian/TechTestApp
cd /home/ubuntu/go/src/github.com/Servian/TechTestApp && bash ./build.sh

# Create Database app in PostgreSQL
#sudo apt-get install -y postgresql-client  
#export PGPASSWORD='changeme'
#psql -U postgres -h demodb-postgres.cc6m3cifzpdr.ap-southeast-2.rds.amazonaws.com -c 'create database app;'

# Modify conf.toml file
sed -i '5s/localhost/demodb-postgres.cc6m3cifzpdr.ap-southeast-2.rds.amazonaws.com/' /home/ubuntu/go/src/github.com/Servian/TechTestApp/dist/conf.toml
sed -i '6s/localhost/0.0.0.0/' /home/ubuntu/go/src/github.com/Servian/TechTestApp/dist/conf.toml


# Feed the data & Start the service
cd /home/ubuntu/go/src/github.com/Servian/TechTestApp/dist/ && ./TechTestApp updatedb -s && ./TechTestApp serve



