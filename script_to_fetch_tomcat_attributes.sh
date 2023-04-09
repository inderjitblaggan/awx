#!/bin/bash
tomcat_container_id=$(docker ps | grep 'catalina.sh run' | awk '{print $1}')
[ -z "$(docker ps | grep 'catalina.sh run'| grep tomcat)" ] && session_type="bach-session-count" || session_type="tomcat-session-count"
echo "=================================================================================================================================================================================="
echo "The command is running on Instance id $(curl -sS http://169.254.169.254/latest/meta-data/instance-id) to fetch tomcat attributes----------------------------------------------------"
timeout 10s docker exec $tomcat_container_id curl -s http://localhost:8080/common/SimpleSystemStatusServlet?admin_pw=teams
echo "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
