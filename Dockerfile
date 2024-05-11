# Use the official Node.js image based on Alpine Linux as base
FROM node:alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install && \
    apk add --no-cache bash

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port your app runs on
EXPOSE 99

# Command to run your application
CMD ["npm", "start"]