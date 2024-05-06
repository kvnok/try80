# Use the Debian Bullseye image from Docker Hub
FROM debian:bullseye

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Remove the default nginx index page
RUN rm -f /var/www/html/index.html

# Copy the index.html file from your local machine into the container
COPY index.html /var/www/html/index.html

# Copy the nginx.conf file into the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start NGINX when the container has provisioned
CMD ["nginx", "-g", "daemon off;"]