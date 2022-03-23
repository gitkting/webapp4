#! /bin/bash
player1=xiaoming # define a player1
player2=ken 
appname=webapp4
echo "**************** $appname publish start... ****************" 
echo "git pull"
echo "dotnet build"
echo "docker build"
#docker build -t img-webapp0 .
docker build -t img-$appname /home/kting/$appname
echo "docker run"
docker rm -f doc-$appname 
#docker run --name doc-webapp0 -p 8588:8587 -d img-webapp0 
docker run -it --name doc-$appname -p 8588:8587 --mount type=bind,source=/opt/data,target=/home/kting -d img-$appname:latest
echo "**************** $appname publish end... ****************"




#! /bin/bash
appname="webapp4"
echo "${appname} publish start..." 
#echo "delete project folder: /home/kting/sourcecode/$appname ..."
#rm -rf /home/kting/sourcecode/$appname
#echo "create project folder: /home/kting/sourcecode/$appname ..."
#mkdir /home/kting/sourcecode/$appname
cd /home/kting/sourcecode/$appname
echo "pull project code from  ..."
#root@DESKTOP-GGG9TD9:/home/kting/sourcecode# git clone git@github.com:gitkting/webapp4.git
#root@DESKTOP-GGG9TD9:/home/kting/sourcecode/webapp4# git pull git@github.com:gitkting/webapp4.git
#git it clone git@github.com:gitkting/webapp4.git 
git pull git@github.com:gitkting/webapp4.git 
#git svn rebase
echo " run dotnet build ..."
cd /
#dotnet restore /home/admin/my/code
dotnet build /home/kting/sourcecode/$appname
echo " run dotnet publish ..."
#dotnet publish /home/admin/my/code  -o /home/admin/my/code/publish
dotnet publish /home/kting/sourcecode/$appname
echo "get old container id ..."
CID=$(docker ps |grep "doc-$appname" |awk '{print $1}')
echo $CID
echo "stop $CID container ..."
if [ "$CID" != "" ];then
docker stop $CID
echo "delete $CID container ..."
docker rm -f $CID
fi

echo "get old images id ..."
IID=$(docker images |grep "img-$appname" |awk '{print $3}')
echo $IID
if [ "$IID" != "" ];then
echo "delete $IID images ..."
docker rmi -f $IID
fi

echo "create docker images ..."
#docker build -t img-webapp0 .
#docker build -t img-$appname /home/kting/sourcecode/$appname 
docker build -t img-$appname /home/kting/sourcecode/webapp4/WebApplication4/bin/Debug/net5.0/publish
sleep 10
echo "create docker container ..."
#docker rm -f doc-$appname 
#docker run -d -p 5002:5002 --name dotnetapigas dotnetapi
docker run -it --name doc-$appname -p 8588:8587 --mount type=bind,source=/opt/data,target=/home/kting -d img-$appname:latest

echo "$appname publish end... "