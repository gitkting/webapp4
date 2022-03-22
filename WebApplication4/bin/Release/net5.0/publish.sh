#! /bin/bash # employ bash shell
player1=xiaoming # define a player1
player2=ken 
appname=webapp0
echo "start publish $appname ... $player1 $player2" # echo is used to printf in terminal

echo "git pull"

echo "dotnet build"

echo "docker build"
docker build -t img-webapp0 .

echo "docker run"
docker rm -f doc-webapp0
docker run --name doc-webapp0 -p 8588:8587 -d img-webapp0 

echo "$appname publish finish"