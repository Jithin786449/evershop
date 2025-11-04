# Deploying EverShop to Dokploy

This guide will help you deploy your EverShop e-commerce platform to Dokploy.

## Prerequisites

- A Dokploy instance running and accessible
- A domain name (optional, but recommended)
- Git repository with your EverShop code

## Deployment Methods

### Method 1: Using Docker Compose (Recommended)

This method deploys both the application and PostgreSQL database together.

#### Step 1: Prepare Your Repository

Ensure these files are in your repository:
- `Dockerfile` ✅ (created)
- `docker-compose.yml` ✅ (created)
- `.dockerignore` ✅ (created)
- `.env.example` ✅ (exists)

#### Step 2: Create Application in Dokploy

1. **Login to Dokploy Dashboard**
   - Navigate to your Dokploy instance

2. **Create New Project**
   - Click "Create Project"
   - Name: `evershop-store` (or your preferred name)

3. **Add Compose Service**
   - Click "Add Service" → "Compose"
   - Select your Git repository
   - Branch: `main` (or your deployment branch)
   - Compose File Path: `docker-compose.yml`

#### Step 3: Configure Environment Variables

In Dokploy, add these environment variables:

```env
# Database Configuration
DB_NAME=evershop
DB_USER=admin
DB_PASSWORD=your_secure_password_here_change_this

# Session Secret (IMPORTANT: Generate a secure random string)
SESSION_SECRET=your_secure_session_secret_min_32_characters_change_this

# Domain Configuration
BASE_URL=https://yourdomain.com

# Node Environment
NODE_ENV=production
```

**Important Security Notes:**
- Change `DB_PASSWORD` to a strong, unique password
- Generate a secure `SESSION_SECRET` (minimum 32 characters)
- You can generate secure secrets using: `openssl rand -base64 32`

#### Step 4: Configure Domain (Optional)

1. In Dokploy, go to your service settings
2. Add your domain under "Domains"
3. Enable SSL/TLS (Let's Encrypt)
4. Update `BASE_URL` environment variable to match your domain

#### Step 5: Deploy

1. Click "Deploy" in Dokploy
2. Wait for the build and deployment to complete (5-10 minutes)
3. Monitor logs for any errors

#### Step 6: Initial Setup

Once deployed, access your store:

1. **Frontend**: `https://yourdomain.com` or `http://your-server-ip:3000`
2. **Admin Panel**: `https://yourdomain.com/admin`

First-time setup:
- The application will automatically create database tables on first run
- Create your admin account through the setup wizard

---

### Method 2: Separate Database (Advanced)

If you want to use an external PostgreSQL database:

#### Step 1: Create PostgreSQL Database

1. In Dokploy, create a new PostgreSQL service:
   - Click "Add Service" → "Database" → "PostgreSQL"
   - Name: `evershop-db`
   - Set username and password
   - Note the internal hostname (usually `evershop-db`)

#### Step 2: Create Application Service

1. Create a new Docker service (not Compose)
2. Select your Git repository
3. Dockerfile path: `Dockerfile`

#### Step 3: Configure Environment Variables

```env
# Database Configuration (use your Dokploy database details)
DB_HOST=evershop-db
DB_PORT=5432
DB_NAME=evershop
DB_USER=admin
DB_PASSWORD=your_database_password

# Session Secret
SESSION_SECRET=your_secure_session_secret_min_32_characters

# Domain Configuration
BASE_URL=https://yourdomain.com

# Node Environment
NODE_ENV=production
```

#### Step 4: Configure Volumes

Add these volume mounts in Dokploy:
- `/app/media` → For uploaded media files
- `/app/public/assets` → For generated assets

#### Step 5: Deploy

Click "Deploy" and monitor the deployment process.

---

## Post-Deployment Configuration

### 1. Configure Store Settings

Access the admin panel at `/admin` and configure:
- Store name and contact information
- Payment gateways (Stripe, PayPal, etc.)
- Shipping methods
- Tax settings
- Email notifications (SMTP)

### 2. Set Up Email (Optional)

Add these environment variables for email functionality:

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your-app-password
SMTP_FROM_EMAIL=noreply@yourdomain.com
SMTP_FROM_NAME=Your Store Name
```

### 3. Configure Payment Gateways (Optional)

For Stripe:
```env
STRIPE_SECRET_KEY=sk_live_...
STRIPE_PUBLISHABLE_KEY=pk_live_...
```

For PayPal:
```env
PAYPAL_CLIENT_ID=your_client_id
PAYPAL_CLIENT_SECRET=your_client_secret
PAYPAL_MODE=live
```

### 4. Set Up File Storage (Optional)

For AWS S3 storage:
```env
FILE_STORAGE=s3
AWS_S3_BUCKET=your-bucket-name
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
```

---

## Monitoring and Maintenance

### Health Checks

The application includes a health check endpoint at `/health`. Dokploy will automatically monitor this.

### Logs

View logs in Dokploy:
1. Go to your service
2. Click "Logs" tab
3. Monitor for errors or issues

### Database Backups

**Important**: Set up regular database backups!

1. In Dokploy, go to your PostgreSQL service
2. Configure automated backups
3. Or use manual backup commands:

```bash
# Backup
docker exec evershop-postgres pg_dump -U admin evershop > backup.sql

# Restore
docker exec -i evershop-postgres psql -U admin evershop < backup.sql
```

### Updating the Application

1. Push changes to your Git repository
2. In Dokploy, click "Redeploy"
3. Monitor the deployment logs
4. Test the updated application

---

## Troubleshooting

### Application Won't Start

1. Check logs in Dokploy
2. Verify all environment variables are set correctly
3. Ensure database is accessible
4. Check if database migrations completed successfully

### Database Connection Issues

1. Verify `DB_HOST` matches your database service name
2. Check database credentials
3. Ensure database service is running
4. Test connection: `docker exec evershop-app nc -zv postgres 5432`

### Build Failures

1. Check if all dependencies are available
2. Verify Node.js version compatibility (requires Node 18+)
3. Check for syntax errors in code
4. Review build logs for specific errors

### Performance Issues

1. Increase container resources in Dokploy
2. Optimize database queries
3. Enable caching
4. Use CDN for static assets

---

## Security Checklist

- [ ] Changed default database password
- [ ] Generated secure SESSION_SECRET (min 32 characters)
- [ ] Enabled HTTPS/SSL
- [ ] Configured firewall rules
- [ ] Set up regular database backups
- [ ] Enabled security headers (already configured in Dockerfile)
- [ ] Reviewed and secured admin panel access
- [ ] Configured rate limiting (if needed)
- [ ] Set up monitoring and alerts

---

## Scaling Considerations

### Horizontal Scaling

To scale your application:

1. Use Dokploy's scaling features
2. Set up a load balancer
3. Use external PostgreSQL (managed database)
4. Use S3 or similar for file storage
5. Implement Redis for session storage

### Performance Optimization

1. Enable caching (Redis)
2. Use CDN for static assets
3. Optimize images
4. Enable gzip compression
5. Implement database indexing

---

## Support and Resources

- **EverShop Documentation**: https://evershop.io/docs
- **Dokploy Documentation**: https://dokploy.com/docs
- **EverShop Discord**: https://discord.gg/GSzt7dt7RM
- **GitHub Issues**: https://github.com/evershopcommerce/evershop/issues

---

## Quick Reference Commands

```bash
# View application logs
docker logs evershop-app -f

# View database logs
docker logs evershop-postgres -f

# Access application container
docker exec -it evershop-app sh

# Access database
docker exec -it evershop-postgres psql -U admin -d evershop

# Restart services
docker-compose restart

# Stop services
docker-compose down

# Start services
docker-compose up -d
```

---

## Environment Variables Reference

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DB_HOST` | Yes | localhost | Database host |
| `DB_PORT` | Yes | 5432 | Database port |
| `DB_NAME` | Yes | evershop | Database name |
| `DB_USER` | Yes | admin | Database user |
| `DB_PASSWORD` | Yes | - | Database password |
| `SESSION_SECRET` | Yes | - | Session encryption key (min 32 chars) |
| `NODE_ENV` | Yes | production | Node environment |
| `BASE_URL` | Yes | - | Full URL of your store |
| `SMTP_HOST` | No | - | SMTP server host |
| `SMTP_PORT` | No | 587 | SMTP server port |
| `SMTP_USER` | No | - | SMTP username |
| `SMTP_PASSWORD` | No | - | SMTP password |
| `STRIPE_SECRET_KEY` | No | - | Stripe secret key |
| `STRIPE_PUBLISHABLE_KEY` | No | - | Stripe publishable key |
| `PAYPAL_CLIENT_ID` | No | - | PayPal client ID |
| `PAYPAL_CLIENT_SECRET` | No | - | PayPal client secret |

---

**Good luck with your deployment! 🚀**
