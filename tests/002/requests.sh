source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/static"
handled_by_8080 "localhost" "http://localhost:9090/static/"
handled_by_8080 "localhost" "http://localhost:9090/static/index.html"

not_handled_by_8080 "localhost" "http://localhost:9090/static2"
not_handled_by_8080 "localhost" "http://localhost:9090/static2/"
not_handled_by_8080 "localhost" "http://localhost:9090/static2/index.html"
not_handled_by_8080 "localhost2" "http://localhost:9090/static"
