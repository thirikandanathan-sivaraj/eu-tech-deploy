# Use official lightweight Node image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies first (layer caching)
COPY app/package*.json ./
RUN npm install

# Copy the rest of the app
COPY app/ .

# Expose the port Express uses
EXPOSE 80

# Start the app
CMD ["npm", "start"]
