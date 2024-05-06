# Use the Debian Bullseye image from Docker Hub
FROM debian:bullseye

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Remove the default nginx index page
RUN rm -f /var/www/html/index.html

# Copy the index.html, styles.css, and script.js files from your local machine into the container
COPY index.html styles.css script.js favicon.ico /var/www/html/

# Copy the nginx.conf file into the container
COPY nginx.conf /etc/nginx/nginx.conf

RUN chmod a+r /var/www/html/*

# Expose port 80
EXPOSE 80

# Start NGINX when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]
