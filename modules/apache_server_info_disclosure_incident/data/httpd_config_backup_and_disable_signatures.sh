bash

#!/bin/bash



# backup the original httpd.conf file

sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak



# disable server signature

sudo sed -i 's/ServerSignature On/ServerSignature Off/g' /etc/httpd/conf/httpd.conf



# disable server tokens

sudo sed -i 's/ServerTokens OS/ServerTokens Prod/g' /etc/httpd/conf/httpd.conf



# restart Apache for the changes to take effect

sudo systemctl restart httpd