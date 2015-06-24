# nginx implementation of webconfig-spec

[![Build Status](https://travis-ci.org/micro-webapps/nginx-cfg.svg)](https://travis-ci.org/micro-webapps/nginx-cfg)

This is an implementation of [webconf-spec](https://github.com/micro-webapps/webconf-spec) for HAProxy. The `nginx-cfg` binary converts the webconf-spec-formatted JSON files into native HAProxy configuration.

As an input, it takes the path to directory with .json files and it generates the nginx configuration files in the output directory

## Supported webconf-spec options

The following table describes current level of webconf-spec implementation:


<!--| Option | Supported | Note |
|--------|:---------:|------|
| certificate| ✔ | |
| certificate_key| ✔ | |
| directories | ✘ | The support is not planned or possible. |
| directories.alias | ✘ | The support is not planned or possible. |
| document_root | ✘ | The support is not planned or possible. |
| index | ✘ | The support is not planned or possible. |
| locations | ✘ | The support is not planned or possible. |
| match | ✘ | |
| match.allow | ✘ | |
| proxy_alias | ✔ | |
| proxy_backend_alias | ✔ | |
| proxy_hostname | ✔ | |
| proxy_port | ✔ | |
| proxy_protocol | ✔ | |
| redirects | ✘ | |
| version | ✔ | |
| virtualhost | ✔ | |-->
