#!/bin/sh

ls /var/mail | while read user; do
        adduser -G users -D -H -s /bin/false $user
done

redis-server /etc/redis.conf 
rspamd --insecure
dkimproxy.out --conf_file=/etc/dkimproxy/dkimproxy_out.conf --daemonize 
smtpd -dv

