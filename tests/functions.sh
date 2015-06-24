dump_error() {
    echo "$1"
    echo "Host: $host"
    echo "URL:  $url"
    echo 'Output of `curl -k -L -H "Host: $host" "$url"`:'
    curl -k -L -v -H "Host: $host" "$url"
    echo "Output of nginx:"
    cat haproxy.output
}

handled_by_8080() {
    host=$1
    url=$2

    curl -L -H "Host: $host" "$url" 2>/dev/null|grep "8080" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8080 backend, but it should be:"
        exit 1
    fi
}

handled_by_8080_ssl() {
    host=$1
    url=$2
    curl -k -L -H "Host: $host" "$url" -v 2>&1|grep "8080" -B100|grep "SSL connection using" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8080 backend using SSL, but it should be:"
        exit 1
    fi
}

not_handled_by_8080() {
    host=$1
    url=$2

    curl -k -L -H "Host: $host" "$url" 2>/dev/null|grep "8080" >/dev/null
    if [ $? == 0 ]; then
        dump_error "URL is handled by 8080 backend, but it should not be:"
        exit 1
    fi
}

handled_by_8081() {
    host=$1
    url=$2

    curl -k -L -H "Host: $host" "$url" 2>/dev/null|grep "8081" >/dev/null
    if [ $? != 0 ]; then
        dump_error "URL is not handled by 8081 backend, but it should be:"
        exit 1
    fi
}

not_handled_by_8081() {
    host=$1
    url=$2

    curl -k -L -H "Host: $host" "$url" 2>/dev/null|grep "8081" >/dev/null
    if [ $? == 0 ]; then
        dump_error "URL is handled by 8081 backend, but it should not be:"
        exit 1
    fi
}
