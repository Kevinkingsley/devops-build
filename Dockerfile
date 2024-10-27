# Use an official Node.js runtime as a parent image
FROM node:14 as build
# Set the working directory
WORKDIR /app
# Copy package.json and package-lock.json files
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the application files
COPY . .
# Build the app for production
RUN npm run build
# Use a lightweight server for the static files
FROM nginx:alpine
# Copy the build folder from the previous stage
COPY --from=build /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]