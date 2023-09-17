FROM alpine

# Upgrade existing packages in the base image
RUN apk --no-cache upgrade

# Install apache from packages with out caching install files
RUN apk add --no-cache apache2 apache2-proxy apache2-ssl apache2-utils

# Turn on apache2 vhost, rewrite, proxy_http and proxy modules
RUN sed -i 's/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/' /etc/apache2/httpd.conf
RUN sed -i 's/#LoadModule\ vhost_alias_module/LoadModule\ vhost_alias_module/' /etc/apache2/httpd.conf
RUN echo "LoadModule proxy_module modules/mod_proxy.so" >> /etc/apache2/httpd.conf
RUN echo "LoadModule proxy_http_module modules/mod_proxy_http.so" >> /etc/apache2/httpd.conf

# Set apache2 to run as www-data user and group
# RUN sed -i 's/User\ apache/User\ www-data/' /etc/apache2/httpd.conf
# RUN sed -i 's/Group\ apache/Group\ www-data/' /etc/apache2/httpd.conf

# Adding vhost config path to httpd.conf
RUN echo "IncludeOptional /etc/apache2/vhost.d/*.conf" >> /etc/apache2/httpd.conf

# Create vhost config directory
RUN mkdir -p /etc/apache2/vhost.d

# Disable default vhost
RUN sed -i 's/^/#/' /etc/apache2/conf.d/default.conf

# Adding the vhost config file in the vhost config directory
ADD app.conf /etc/apache2/vhost.d/app.conf

# Open port for httpd access
EXPOSE 80

# Run httpd in foreground so that the container does not quit
CMD ["-D","FOREGROUND"]

# Start httpd when container runs
ENTRYPOINT ["/usr/sbin/httpd"]

# Set the working directory to the apache config location
WORKDIR /etc/apache2

###--------------------END-------------------------------------#