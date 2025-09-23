#!/bin/sh

ROOT_TRUST_DIR=/var/lib/unbound
ROOT_TRUST_ANCHOR_FILE=${ROOT_TRUST_DIR}/root.key
ROOT_CONF_DIR=/etc/unbound
ROOT_HINTS_FILE=${ROOT_TRUST_DIR}/root.hints
ROOT_HINTS_FILE_FAILED=/tmp/root.hints.failed

if [ "$#" -eq 0 ];then
  mkdir -p ${ROOT_TRUST_DIR}
  chown unbound:unbound ${ROOT_TRUST_DIR}
  unbound-anchor -a ${ROOT_TRUST_ANCHOR_FILE} -v
  chown unbound:unbound ${ROOT_TRUST_ANCHOR_FILE}
  curl -Ss -m 10 https://www.internic.net/domain/named.root -o /tmp/hints
  if [ $(grep -i ROOT-SERVERS /tmp/hints | wc -l) -gt 0 ];then
    cat /tmp/hints | grep -v AAAA|grep -v B.ROOT-SERVERS.NET > /tmp/hints_filtered
    mv /tmp/hints_filtered ${ROOT_HINTS_FILE}
  else
    echo "WARNING: Failed to download root.hints"
    touch ${ROOT_HINTS_FILE_FAILED}
  fi
  exec unbound -c ${ROOT_CONF_DIR}/unbound.conf
else
  exec "$@"
fi
