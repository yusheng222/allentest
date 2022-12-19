#! bin/bash
# 外部传给内部的变量脚本
app_name="allentest"
port="8888"
docker_username="c463038352"

echo "对容器存活进行判断"
if test -n "$(docker ps -a |grep $app_name)" ; then
  echo "停止并且删除容器和上版本镜像"
  docker stop $app_name
  docker rm $app_name
  docker rmi $docker_username/$app_name:latest
else
  echo "未检查到$app_name容器运行"
fi

echo "获取最新的镜像"
docker pull $docker_username/$app_name:latest
echo "启动服务"
# 有需要添加的环境变量随时添加
docker run -itd\
 -e TZ="Asia/Shanghai"\
 -e SERVER_PORT=$port\
 -p $port:$port\
 --name $app_name  $docker_username/$app_name:latest
