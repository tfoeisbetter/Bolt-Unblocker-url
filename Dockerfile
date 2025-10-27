# Use Node.js Alpine image (smaller size)
# Use Node 20 (project requires Node >=20)
FROM node:20-alpine

# Enable corepack and install the pnpm version declared in package.json
RUN corepack enable && corepack prepare pnpm@9.12.3 --activate

# Set working directory
WORKDIR /app

# Set production environment
ENV NODE_ENV=production

# Copy package files first to leverage Docker layer caching
COPY package.json pnpm-lock.yaml ./

# Install dependencies. The project's pnpm lockfile and package.json may differ
# in some dev trees; to avoid build-time failure in the container use
# --no-frozen-lockfile. If you prefer strict reproducible builds, regenerate
# and commit an updated pnpm-lock.yaml locally and switch back to
# --frozen-lockfile.
RUN pnpm install --no-frozen-lockfile

# Copy remaining project files
COPY . .

# Expose the port the app listens on (defaults to 8080)
EXPOSE 8080

# Start the application
CMD ["pnpm", "start"]
