#! /bin/sh 
#PROJECT=webSimplePOS
#GIT_USER=catyku
#git clone https://${GIT_USER}:${GIT_PWD}@github.com/${PROJECT_OWNER}/${PROJECT}
git clone https://github.com/${PROJECT_OWNER}/${PROJECT}
cd ${PROJECT} 
mvn -Dfile.encoding=UTF-8 -Pproduct clean install
cp  -rf ./target/${PROJECT}-*.war  /root/target/${PROJECT}.war
