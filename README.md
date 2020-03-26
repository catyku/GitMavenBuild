# GitMavenBuild
 java auto build maven project
### start 
```shell
chmod u+x buildDocker.sh
cd SQLiteExample
chmod u+x makeSQLiteExample.sh
./makeSQLiteExample.sh
```

### options
rewrite text `SQLiteExample.env ` for your project 
```
GIT_USER=catyku
GIT_PWD=
PROJECT_OWNER=catyku
PROJECT=SQLiteExample
```
`makeSQLiteExample.sh` change directory to meets the your environment
```shell
docker run --env-file=SQLiteExample.env -ti --rm --name my-maven-project -v /opt/github/GitMavenBuild/m2:/root/.m2 -v /opt/github/GitMavenBuild/webapps/:/root/target catyku/mavenbuild bash -c "/root/run.sh"
```
