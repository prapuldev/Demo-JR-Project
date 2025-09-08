# Step 1: Build the React app
FROM node:18 AS build

WORKDIR /home/p259/Documents/Git projects/e-commerce-site-master

# Copy package.json and install deps
COPY package*.json ./
RUN npm install

# Copy the rest of the code
COPY . .

# Build production files
RUN npm run build


# Step 2: Serve the React app using Nginx
FROM nginx:alpine

# Copy build folder to Nginx html directory
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]
