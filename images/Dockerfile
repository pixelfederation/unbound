FROM alpine:3.18

#RUN echo "http://dl-4.alpinelinux.org/alpine/latest-stable/main/" >> /etc/apk/repositories && \
RUN apk add --no-cache --update unbound bind-tools curl

WORKDIR /etc/unbound

COPY etc/unbound.conf /etc/unbound/
COPY files/root.hints /var/lib/unbound/root.hints
COPY files/entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
