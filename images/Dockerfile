FROM alpine:latest

#RUN echo "http://dl-4.alpinelinux.org/alpine/latest-stable/main/" >> /etc/apk/repositories && \
RUN apk add --no-cache --update unbound bind-tools curl

WORKDIR /etc/unbound

COPY etc/unbound.conf /etc/unbound/
COPY files/entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
