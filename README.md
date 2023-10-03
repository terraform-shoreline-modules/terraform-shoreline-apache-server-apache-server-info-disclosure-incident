
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache Server Info Disclosure Incident
---

The Apache Server Info Disclosure Incident refers to a security vulnerability in Apache servers that enables an attacker to gain access to sensitive system information. This type of incident involves an unauthorized user exploiting a flaw in the Apache server configuration to obtain confidential information such as server version, installed modules, and other system details. Attackers can use this information to launch further attacks on the system, compromise data, or disrupt services. It is important to address this incident type promptly to prevent any potential security breaches.

### Parameters
```shell
export DIRECTORY_="PLACEHOLDER"

export HOSTNAME="PLACEHOLDER"

export IP_ADDRESS="PLACEHOLDER"

export N="PLACEHOLDER"

export PARAMETER="PLACEHOLDER"

export SERVER_IP_ADDRESS="PLACEHOLDER"
```

## Debug

### Check Apache version
```shell
apache2 -v
```

### Check Apache configuration files for sensitive information
```shell
grep -Ri "${DIRECTORY_}" /etc/apache2/
```

### Check Apache access logs for suspicious activity
```shell
tail -n 100 /var/log/apache2/access.log | grep -i "GET /"
```

### Check Apache error logs for any errors or warnings
```shell
tail -n 100 /var/log/apache2/error.log
```

### Check Apache mod_status module for any unusual activity
```shell
curl -s http://${SERVER_IP_ADDRESS}/server-status?auto | awk '/^BusyWorkers/ {print $2}'
```

### Misconfiguration of Apache server settings that allowed unauthorized access to sensitive server information.
```shell


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


```

## Repair

### Update the Apache server software to the latest version to address known vulnerabilities.
```shell


#!/bin/bash



# Update Apache server software

sudo apt-get update

sudo apt-get upgrade apache2


```

### Disable server info disclosure by modifying the Apache configuration file (httpd.conf) to remove the "ServerSignature" and "ServerTokens" directives.
```shell
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


```