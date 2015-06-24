source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/owncloud"
handled_by_8080 "localhost" "http://localhost:9090/owncloud/"
handled_by_8080 "localhost" "http://localhost:9090/owncloud/another"

not_handled_by_8080 "localhost" "http://localhost:9090/owncloud2"
not_handled_by_8080 "localhost" "http://localhost:9090/owncloud2/"
not_handled_by_8080 "localhost2" "http://localhost:9090/owncloud2/"
