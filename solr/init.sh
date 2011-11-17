#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

aptitude -y install sun-java6-jre unzip
wget http://forge.typo3.org/projects/extension-solr/repository/raw/trunk/resources/shell/install-solr.sh
chmod +x install-solr.sh
./install-solr.sh

/opt/solr-tomcat/tomcat/bin/shutdown.sh

patch -u -p0 < $SCRIPT_PATH/patch.diff

/opt/solr-tomcat/tomcat/bin/startup.sh
