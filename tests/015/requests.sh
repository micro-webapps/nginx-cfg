source ../functions.sh

handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test.txt"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test/test.txt"

handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test.php"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test/test.php"

handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test.php5"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test/test.php5"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test/test"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test/"
handled_by_8081 "localhost" "http://localhost:9090/redirect-test"

not_handled_by_8081 "localhost" "http://localhost:9090/blog3/"
not_handled_by_8081 "localhost" "http://localhost:9090/blo"
not_handled_by_8081 "localhost" "http://localhost:9090/blogg"
