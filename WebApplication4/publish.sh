#! /bin/bash
appname="webapp4"
sourceFolder= "/home/kting/sourcecode/$appname/"
echo "**************** ${appname} publish start ***************."
echo "...............create folder ................"
#echo "delete project folder: /home/kting/sourcecode/$appname ..."
#rm -rf /home/kting/sourcecode/$appname
#echo "create project folder: /home/kting/sourcecode/$appname ..."
#mkdir /home/kting/sourcecode/$appname
echo "...............git pull sourcecode ................"
# -d 参数判断 $sourceFolder 是否存在
#判断文件夹是否存在 -d
if [[ ! -d "$sourceFolder" ]]; then
  cd /home/kting/sourcecode
  git clone https://github.com/gitkting/webapp4.git
else
  cd /home/kting/sourcecode/$appname
  git pull https://github.com/gitkting/webapp4.git
fi
 
echo "pull project code from  ..."
#root@DESKTOP-GGG9TD9:/home/kting/sourcecode# git clone git@github.com:gitkting/webapp4.git
#root@DESKTOP-GGG9TD9:/home/kting/sourcecode/webapp4# git pull git@github.com:gitkting/webapp4.git
#git it clone git@github.com:gitkting/webapp4.git
#git pull git@github.com:gitkting/webapp4.git
#git pull https://github.com/gitkting/webapp4.git
#git svn rebase
echo "...............dotnet build ...................."
cd /
#dotnet restore /home/admin/my/code
dotnet build /home/kting/sourcecode/$appname
echo " run dotnet publish ..."
#dotnet publish /home/admin/my/code  -o /home/admin/my/code/publish
dotnet publish /home/kting/sourcecode/$appname
echo "................delete old image and container......................"
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

echo ".......................create docker images ..........................."
#docker build -t img-webapp0 .
#docker build -t img-$appname /home/kting/$appname
docker build -t img-$appname /home/kting/sourcecode/webapp4/WebApplication4/bin/Debug/net5.0/publish
sleep 10
echo "......................create docker container ...................."
#docker rm -f doc-$appname
#docker run -d -p 5002:5002 --name dotnetapigas dotnetapi
docker run -it --name doc-$appname -p 8588:8587 --mount type=bind,source=/opt/data,target=/home/kting -d img-$appname:latest

echo "**************************** $appname publish end *****************************. "





/////////////////////////////////////////////////////
vim 操作    
vim filename
 
然后按 “i” 是修改文件，更改内容了； 
按 “Esc” 就回到命令模式； 
按 “：”就可以输入命令了；
wq 保存
然后 保存后退出。

Esc
输入冒号（即shift+分号）
输入wq
ENTER
 全选（高亮显示）：按esc后，然后ggvG或者ggVG

全部复制：按esc后，然后ggyG

全部删除：按esc后，然后dG

解析：

gg：是让光标移到首行，在vim才有效，vi中无效 

v ： 是进入Visual(可视）模式 

G ：光标移到最后一行 

选中内容以后就可以其他的操作了，比如： 
d  删除选中内容 
y  复制选中内容到0号寄存器 
"+y  复制选中内容到＋寄存器，也就是系统的剪贴板，供其他程序用 
