# ---------- Build Stage ----------
    FROM node:18-bullseye AS build

    # Install dependencies needed for native builds
    RUN apt-get update && apt-get install -y python3 make g++ git libvips-dev && rm -rf /var/lib/apt/lists/*
    
    # Set working directory
    WORKDIR /usr/src/app
    
    # Copy package.json and package-lock.json
    COPY my-strapi-app/package*.json ./
    
    # Install all dependencies, using npm ci for consistency
    RUN npm ci
    
    # Copy the rest of the application
    COPY my-strapi-app/ ./
    
    # Build Strapi Admin Panel
    RUN npm run build
    
    # ---------- Production Stage ----------
    FROM node:18-bullseye
    
    # Set NODE_ENV to production
    ENV NODE_ENV=production
    
    # Set working directory
    WORKDIR /usr/src/app
    
    # Install runtime libraries needed by sharp, better-sqlite3, etc.
    RUN apt-get update && apt-get install -y libvips-dev && rm -rf /var/lib/apt/lists/*
    
    # Copy the built app from the build stage
    COPY --from=build /usr/src/app /usr/src/app
    
    # Rebuild native modules like better-sqlite3 in the production environment
    RUN npm rebuild better-sqlite3 --build-from-source
    
    # Prune development dependencies to reduce image size
    RUN npm prune --production
    
    # Expose Strapi port
    EXPOSE 1337
    
    # Start Strapi
    CMD ["npm", "start"]
    