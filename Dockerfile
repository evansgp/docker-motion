FROM alpine:latest

ENV PYCURL_SSL_LIBRARY openssl

RUN apk update && \
    apk upgrade && \
    apk add gcc musl-dev libcurl curl-dev libjpeg jpeg-dev python python-dev py-pip py-setuptools && \
    pip install --upgrade pip && \
    pip install tornado jinja2 pillow pycurl motioneye && \
    apk --purge -v del python-dev py-pip gcc musl-dev curl-dev jpeg-dev && \
    rm /var/cache/apk/*

RUN mkdir /etc/motioneye && \
    cp /usr/share/motioneye/extra/motioneye.conf.sample /etc/motioneye/motioneye.conf

CMD /usr/bin/meyectl startserver -c /etc/motioneye/motioneye.conf

VOLUME /etc/motioneye
VOLUME /var/lib/motioneye

EXPOSE 8765
