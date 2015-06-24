source ../functions.sh

handled_by_8080_ssl "localhost" "https://localhost:9443/static"
handled_by_8080_ssl "localhost" "https://localhost:9443/static/"
handled_by_8080_ssl "localhost" "https://localhost:9443/static/index.html"

not_handled_by_8080 "localhost" "https://localhost:9443/static2"
not_handled_by_8080 "localhost" "https://localhost:9443/static2/"
not_handled_by_8080 "localhost" "https://localhost:9443/static2/index.html"
not_handled_by_8080 "localhost2" "https://localhost:9443/static"
