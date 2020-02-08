#! /bin/bash

sudo apt-get update -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu

# Download Source Code 
git clone https://github.com/servian/TechTestApp.git
cd TechTestApp && cp conf.toml conf.toml_bak

# Modify conf.toml file
sed -i '5s/localhost/demodb-postgres.cc6m3cifzpdr.ap-southeast-2.rds.amazonaws.com/' /home/ubuntu/TechTestApp/conf.toml
sed -i '6s/localhost/0.0.0.0/' /home/ubuntu/TechTestApp/conf.toml

# Build the docker image
docker build . -t techtestapp:lastest

# Run docker image
docker run -d -p 3000:3000 --name=test --restart=always techtestapp:latest serve