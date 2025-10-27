# Use Node.js Alpine image (smaller size)
FROM node:18-alpine

# Enable corepack and install pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm i --frozen-lockfile

# Copy all project files
COPY . .

# Expose port 8080
EXPOSE 8080

# Start the application
CMD ["pnpm", "start"]
