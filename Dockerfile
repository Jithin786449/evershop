# Multi-stage build for EverShop on Dokploy
FROM node:18-alpine AS base

# Install dependencies only when needed
FROM base AS deps
RUN apk add --no-cache libc6-compat python3 make g++
WORKDIR /app

# Copy package files
COPY package*.json ./
COPY packages ./packages

# Install dependencies
RUN npm ci --legacy-peer-deps

# Build stage
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Set environment to production for build
ENV NODE_ENV=production

# Build the application
RUN npm run build

# Production stage
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production

# Create a non-root user
RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 evershop

# Copy necessary files from builder
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.evershop ./.evershop
COPY --from=builder /app/packages ./packages
COPY --from=builder /app/config ./config
COPY --from=builder /app/translations ./translations
COPY --from=builder /app/bin ./bin
COPY --from=builder /app/babel.config.js ./
COPY --from=builder /app/jsconfig.json ./

# Create necessary directories
RUN mkdir -p /app/media /app/public/assets
RUN chown -R evershop:nodejs /app

USER evershop

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application
CMD ["npm", "start"]
