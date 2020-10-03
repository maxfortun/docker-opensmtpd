#!/bin/sh

ls /var/mail | while read user; do
        adduser -D -H -s /bin/false $user
done

smtpd -dv

