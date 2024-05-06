# Use the official Debian image
FROM debian:bullseye

# Install NGINX and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl

# Create SSL/TLS certificate directory
RUN mkdir /etc/nginx/ssl

# Generate a self-signed SSL/TLS certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.pem -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=NL/ST=Noord-Holland/L=Amsterdam/O=42/OU=Codam/CN=kkroon/"

# Copy your index.html file to the NGINX HTML directory
COPY index.html /usr/share/nginx/html/

# Copy custom Nginx configuration for HTTPS
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 443 (HTTPS)
EXPOSE 443

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
