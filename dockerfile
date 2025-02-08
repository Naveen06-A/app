# Use official Node.js LTS image
FROM node:16-alpine

# Set production environment
ENV NODE_ENV=production

# Create app directory
WORKDIR /usr/src/app

# Install dependencies first for layer caching
COPY package*.json ./
RUN npm ci --only=production

# Copy app source
COPY . .

# Run as non-root user
RUN chown -R node:node .
USER node

# Expose port
EXPOSE ${PORT:-3000}

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl --fail http://localhost:${PORT:-3000}/health || exit 1

# Start command
CMD ["node", "app.js"]