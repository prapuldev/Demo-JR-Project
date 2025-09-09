# Step 1: Build the React app
FROM node:18 AS build

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Build production-ready React app
RUN npm run build


# Step 2: Serve the React app using Nginx
FROM nginx:alpine

# Copy build folder to Nginx html directory
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
