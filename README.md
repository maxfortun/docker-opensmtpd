# docker-opensmtpd

In [mnt/etc/smtpd](mnt/etc/smtpd) and in [mnt/etc/dkimproxy](mnt/etc/dkimproxy):  
```
for sample in *.sample; do cp $sample ${sample%%.sample}; done  
```
Fill out the resulting configs with your appropriate information.   

Create folders for all users you want to receive mail in mnt/var/mail/`user`, where `user` is the user name.  
