

#!/bin/bash



# Check if Apache server is installed

if ! command -v apache2 >/dev/null 2>&1 ; then

  echo "Apache server is not installed on this machine."

  exit 1

fi



# Check Apache server configuration for sensitive information disclosure

if grep -q -i "ServerTokens" /etc/apache2/apache2.conf && grep -q -i "ServerSignature" /etc/apache2/apache2.conf; then

  echo "Apache server is configured to display server version and other sensitive information."

  exit 0

else

  echo "Apache server is not configured to display sensitive information."

  exit 1

fi