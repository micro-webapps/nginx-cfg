source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/static"
not_handled_by_8080 "localhost" "http://localhost:9090/static/test/test.txt"
handled_by_8080 "localhost" "http://localhost:9090/static/test/test.html"
