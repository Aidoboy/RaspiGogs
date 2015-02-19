#!/bin/bash
echo https://go.googlesource.com/go/+refs
read goVersion -p "Pick a go version (go1.4.2 as of Feb 19 2015) from the above link :"
# Create a user named 'git'
sudo adduser --disabled-login --gecos 'Gogs' git
su git <<EOF
cd ~
# create a folder to install 'go'
mkdir local
cd local
# Install GO
git clone https://go.googlesource.com/go
cd go
git checkout $goVersion
cd src
./all.bash
#Set GO system variables
cd ~
echo 'export GOROOT=$HOME/local/go' >> $HOME/.bashrc
echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> $HOME/.bashrc
source $HOME/.bashrc
# Install gopm
go get -u github.com/gpmgo/gopm
#Install gogs
# Download and install dependencies
go get -u github.com/gogits/gogs
# Build main program
cd $GOPATH/src/github.com/gogits/gogs
go build
EOF
