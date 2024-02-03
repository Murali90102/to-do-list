# Use a lightweight, official Nginx image as a base
FROM nginx:alpine

# Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Copy the contents of your local project directory to the container
COPY . .

# Expose the port the Nginx server will run on
EXPOSE 80

# Command to start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
