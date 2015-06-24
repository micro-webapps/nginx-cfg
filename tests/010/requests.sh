source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/blog"
handled_by_8080 "localhost" "http://localhost:9090/blog/"
handled_by_8080 "localhost" "http://localhost:9090/blog/index.html"

handled_by_8080_ssl "localhost" "https://localhost:9443/blog"
handled_by_8080_ssl "localhost" "https://localhost:9443/blog/"
handled_by_8080_ssl "localhost" "https://localhost:9443/blog/index.html"

not_handled_by_8080 "localhost" "http://localhost:9090/blog2"
not_handled_by_8080 "localhost" "http://localhost:9090/blog2/"
not_handled_by_8080 "localhost" "http://localhost:9090/blog2/index.html"
not_handled_by_8080 "localhost2" "http://localhost:9090/blog"
