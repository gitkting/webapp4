#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
#WORKDIR /src
#COPY ["WebApplication4/WebApplication4.csproj", "WebApplication4/"]
#RUN dotnet restore "WebApplication4/WebApplication4.csproj"
#COPY . .
#WORKDIR "/src/WebApplication4"
#RUN dotnet build "WebApplication4.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "WebApplication4.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "WebApplication4.dll"]
#
FROM mcr.microsoft.com/dotnet/aspnet:5.0-buster-slim AS base 
#.net 5基础镜像，很明显没有了那个core
WORKDIR /app
#设置工作目录
COPY . /app 
#这里是将当前目录下的文件拷贝到 镜像 /app 目录下面
##EXPOSE 8586 
#暴露出去的端口，这里我们通过程序里面监听不使用这个配置

# set up network
#ENV ASPNETCORE_URLS http://+:8587

##使用国内镜像源
RUN echo "deb http://mirrors.aliyun.com/debian/ buster main non-free contrib\n\
deb http://mirrors.aliyun.com/debian-security buster/updates main\n\
deb http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\n\
deb http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian-security buster/updates main\n\
deb-src http://mirrors.aliyun.com/debian/ buster main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ buster-updates main non-free contrib\n\
deb-src http://mirrors.aliyun.com/debian/ buster-backports main non-free contrib" > /etc/apt/sources.list


# 用gdi+绘制的功能就需要安装这个包支持
#RUN apt-get update && apt-get install -y libgdiplus && apt-get clean && ln -s /usr/lib/libgdiplus.so /usr/lib/gdiplus.dll
# 运行 CMD命令
ENTRYPOINT ["dotnet", "WebApplication4.dll"]