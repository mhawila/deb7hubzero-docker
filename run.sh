#!/bin/bash

# Start mysql
/etc/init.d/mysql restart

# Start apache
/usr/sbin/apache2 -D FOREGROUND
