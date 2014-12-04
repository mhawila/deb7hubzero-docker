#!/bin/bash

# Start mysql
/etc/init.d/mysql start

# Start apache
/usr/sbin/apache2 -D FOREGROUND
