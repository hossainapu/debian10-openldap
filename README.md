# debian10-openldap
The goal of this project is to build and run OpenLDAP-2.4.50 from source and run in Debian 10 docker image. The file slapd.ldif is being using for startup 
with a baseDN, and default rootDN with password. You may change your baseDN and RootDN and password in this file before going to build.

Here is the command to build this docker image:

<code>docker build -t hossainapu/openldap .</code>

This build will take time depending to your network performance. After finish building make sure that port 389 is not being using in your system.

Now lets start uisng following command:

<code> docker run -p 389:389 hossainapu/openldap:latest</code>

Your docker container is now running and openLDAP is listening on 389 port.

You may login to your container using:

<code>docker exec -it XXXXX /bin/bash</code>

XXXXX is the container id. Now execute 

<code>netstat -pltn</code>

You should see your ldap is running on port 389.
