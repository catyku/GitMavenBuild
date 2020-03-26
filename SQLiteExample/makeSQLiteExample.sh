docker run --env-file=SQLiteExample.env -ti --rm --name my-maven-project -v /opt/github/GitMavenBuild/m2:/root/.m2 -v /opt/github/GitMavenBuild/webapps/:/root/target catyku/mavenbuild bash -c "/root/run.sh"

