#!/bin/bash
tomcat_container_id=$(docker ps | grep 'catalina.sh run' | awk '{print $1}')
[ -z "$(docker ps | grep 'catalina.sh run'| grep tomcat)" ] && session_type="bach-session-count" || session_type="tomcat-session-count"
timeout 10s docker exec $tomcat_container_id curl -s http://localhost:8080/common/SimpleSystemStatusServlet?admin_pw=teams | grep session_count  > temp.txt
instance_id=$(curl -sS http://169.254.169.254/latest/meta-data/instance-id)
sed -i "s/session_count/tomcat-session-count/g" temp.txt
echo "{instance_id:$instance_id,tomcat-session-count=$(grep -oE '[0-9]+' temp.txt)}" > output.txt
cat output.txt
