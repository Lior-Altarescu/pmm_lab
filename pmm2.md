## PMM2_LAB  

This lab is demo where you will create a pmm2 environment with mysql as database nodes

The Lab is comprised out of 
- Pmm-Server
- Pmm-Client
- Mysql 5.7
- Mysql 8 

### Getting started 
___
Inorder to start you environment you'll need to create a env file   

``` bash
echo "
MYSQL_ROOT_PASSWORD=<password>
PMM_AGENT_SERVER_ADDRESS=pmm-server:443
PMM_AGENT_SERVER_USERNAME=admin
PMM_AGENT_SERVER_PASSWORD=admin
PMM_AGENT_SERVER_INSECURE_TLS=1
PMM_AGENT_CONFIG_FILE=pmm-agent.yml
PMM_AGENT_SETUP_CONTAINER_NAME=pmm-client
PMM_AGENT_SETUP_AZ=region ( optional )
PMM_AGENT_SETUP_REGION=az ( optional )
PMM_USER=<pmm user>
PMM_PASSWORD=<pmm pass>
PMM_AGENT_SETUP=1 " > config/.env.dev
```

useful command
```bash
starting the environment:    docker-compose  --env-file ./config/.env.dev up -d
checking the environment:    docker-compose  ps
stopping the environment:    docker-compose  down
checking the logs:           docker-compose  logs <container name>
```
adding services through pmm client. 

Adding mysql8  

```docker exec -it pmm-client pmm-admin add mysql --username=<pmm user> --password=<pmm pass> --query-source='perfschema' --host=mysql-8 --port=3306 --environment=prod  --cluster=sample mysql8```

Adding mysql5  

```docker exec -it pmm-client pmm-admin add mysql --username=<pmm user> --password=<pmm pass> --query-source='perfschema' --host=mysql-57 --port=3306 --environment=dev --cluster=sample mysql5```

Check the pmm-client

```docker exec -it pmm-client pmm-admin list```

If you want to run a stress tool to see how it looks inside the pmm , you can use these commands  

```mysqlslap --auto-generate-sql --auto-generate-sql-load-type=read --auto-generate-sql-execute-number=10 --create-schema=dbawesome --concurrency=30 --no-drop -uroot -p<password> -h 127.0.0.1```

```mysqlslap --auto-generate-sql --auto-generate-sql-load-type=key --auto-generate-sql-execute-number=10 --create-schema=iloug --auto-generate-sql-write-number=100 --auto-generate-sql-guid-primary --number-int-cols=10 --concurrency=20 --no-drop -uroot  -p<password> -h 127.0.0.1``` 


### Please checkout  Percona PMM [Documentation](https://www.percona.com/doc/percona-monitoring-and-management/2.x/index.html)  For more Information =)

