#!/bin/bash
SCRIPT_PATH="$( cd "$(dirname "$0")" && pwd )";

cd $SCRIPT_PATH/apache/conf
diff -Paur ../orig-conf . | grep -v '^Only' > ../patch.diff

cd $SCRIPT_PATH/mysql/conf
diff -Paur ../orig-conf . | grep -v '^Only' > ../patch.diff

cd $SCRIPT_PATH/nginx/conf
diff -Paur ../orig-conf . | grep -v '^Only' > ../patch.diff

cd $SCRIPT_PATH/php/conf
diff -Paur ../orig-conf . | grep -v '^Only' > ../patch.diff
