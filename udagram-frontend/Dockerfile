### Build Stage
FROM beevelop/ionic:v2021.06.1 AS ionic

# Check Node.js and npm versions to match the project's requirements
RUN node -v && npm -v

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy the rest of the app and build the project
COPY . .
RUN ionic build --prod

### Production Stage
FROM nginx:alpine

# Copy Nginx configuration (optional, if you need custom routing)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built app from the ionic build stage to the Nginx directory
COPY --from=ionic /usr/src/app/www /usr/share/nginx/html

# Expose port 80 if necessary (optional, but recommended)
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
