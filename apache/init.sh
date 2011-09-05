#!/bin/bash

# Use Apache as webserver if the repository contains .htaccess files
aptitude install apache2

mv conf/* /etc/apache2/

/etc/init.d/apache restart