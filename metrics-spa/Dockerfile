# Use Node.js 22.2 as the base image
FROM node:22.2.0-bullseye-slim

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the TypeScript code
RUN npm run build

# Expose port 3000 (assuming your React app runs on this port)
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
