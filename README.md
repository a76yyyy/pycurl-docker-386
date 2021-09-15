# Pycurl-Docker-386

Python:3.8-Alpine latest with pycurl for linux/386(not support TLS1.3 and Http3)

## VERSION

- PYTHON_VERSION == 3.8
- CURL_VERSION == 7.79.0
- OPENSSL_VERSION == 1.1.1l

```bash
LDFLAGS="-Wl,-rpath,/usr/lib" ./configure \
    --with-ssl \
    --with-nghttp2=/usr \
    --prefix=/usr \
    --enable-ipv6 \
    --enable-unix-sockets \
    --without-libidn \
    --disable-static \
    --disable-ldap \
    --with-pic
```
