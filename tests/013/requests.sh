source ../functions.sh

handled_by_8080 "localhost" "http://localhost:9090/blog/test.txt"
handled_by_8080 "localhost" "http://localhost:9090/blog/test/test.txt"

handled_by_8081 "localhost" "http://localhost:9090/blog/test.php"
handled_by_8081 "localhost" "http://localhost:9090/blog/test/test.php"

handled_by_8081 "localhost" "http://localhost:9090/blog/test.php5"
handled_by_8081 "localhost" "http://localhost:9090/blog/test/test.php5"
handled_by_8081 "localhost" "http://localhost:9090/blog/test"

# Test index.php
handled_by_8081 "localhost" "http://localhost:9090/blog/"
