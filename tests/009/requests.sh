source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/blog"
handled_by_8080 "localhost" "http://localhost:9090/blog/"
handled_by_8080 "localhost" "http://localhost:9090/blog/another"

not_handled_by_8080 "localhost" "http://localhost:9090/blog2"
not_handled_by_8080 "localhost" "http://localhost:9090/blog2/"
not_handled_by_8080 "localhost2" "http://localhost:9090/blog2/"
