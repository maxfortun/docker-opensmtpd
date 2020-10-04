#!/bin/sh

ls /var/mail | while read user; do
        adduser -D -H -s /bin/false $user
done

dkimproxy.out --conf_file=/etc/dkimproxy/dkimproxy_out.conf --daemonize 
smtpd -dv

