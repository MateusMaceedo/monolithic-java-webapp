#!/bin/bash
AWS_REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r ".region")

#setting variables from secrets manager
SECRET_NAME=$(aws secretsmanager list-secrets --query 'SecretList[?starts_with(Name, `Lab2DBInstance`) == `true`].{Name:Name}' --output text --region ${AWS_REGION})
json=$(aws secretsmanager get-secret-value --secret-id ${SECRET_NAME} --region $AWS_REGION | jq --raw-output .SecretString)
$(jq -r 'to_entries | map("export "+.key + "=" + (.value | tostring)) | .[]' <<<"$json") 

java -jar /app/monolithic-java-webapp.jar --rds.dbinstance.host=jdbc:mysql://${host}:3306/DevEssentialsDB --rds.dbinstance.username=${username} --rds.dbinstance.password=${password} > /dev/null 2> /dev/null < /dev/null &