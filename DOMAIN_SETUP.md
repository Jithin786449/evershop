# Domain Setup Guide for globelconnect.store

This guide explains how to configure and deploy your EverShop store with the domain **globelconnect.store**.

## 📋 Overview

Your EverShop e-commerce platform has been configured to use the domain `globelconnect.store`. This setup includes:

- Configuration files for development and production environments
- Vercel deployment configuration
- Environment variable templates
- Security headers and redirects

## 🗂️ Configuration Files

### 1. `/config/default.json`
Base configuration for development environment with default settings for:
- Shop settings (currency, language, timezone)
- Database connection
- Session management
- Product image dimensions

### 2. `/config/production.json`
Production-specific configuration with:
- Environment variable placeholders for sensitive data
- Domain configuration: `globelconnect.store`
- HTTPS enforcement
- SSL database connection settings

### 3. `/vercel.json`
Vercel deployment configuration including:
- Domain aliases (globelconnect.store, www.globelconnect.store)
- Build settings
- Routing rules for assets and media
- Security headers (HSTS, XSS Protection, etc.)
- WWW redirect (non-www → www)
- Environment variable references

### 4. `/.env.example`
Template for environment variables needed in production

## 🚀 Deployment Steps

### Step 1: Set Up Database

1. Create a PostgreSQL database for your store
2. Note down the connection details:
   - Host
   - Port (default: 5432)
   - Database name
   - Username
   - Password

### Step 2: Configure Environment Variables

#### For Local Development:
1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Update the values in `.env` with your local database credentials

#### For Vercel Production:
1. Go to your Vercel project dashboard
2. Navigate to **Settings** → **Environment Variables**
3. Add the following environment variables:

   ```
   NODE_ENV=production
   DB_HOST=your-database-host
   DB_PORT=5432
   DB_NAME=evershop
   DB_USER=your-database-user
   DB_PASSWORD=your-secure-password
   SESSION_SECRET=your-secure-session-secret-min-32-chars
   ```

   **Note:** Use Vercel's secret management by prefixing with `@` for sensitive values:
   - `@db_host`
   - `@db_password`
   - `@session_secret`

### Step 3: Install Dependencies

```bash
npm install
```

### Step 4: Run Database Migrations

```bash
npm run setup
```

This will create all necessary database tables and initial data.

### Step 5: Build the Application

```bash
npm run build
```

### Step 6: Deploy to Vercel

#### Option A: Using Vercel CLI
```bash
# Install Vercel CLI if not already installed
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel --prod
```

#### Option B: Using Git Integration
1. Push your code to GitHub/GitLab/Bitbucket
2. Import the repository in Vercel dashboard
3. Vercel will automatically detect the configuration
4. Add environment variables in Vercel dashboard
5. Deploy

### Step 7: Configure Domain in Vercel

1. Go to your Vercel project dashboard
2. Navigate to **Settings** → **Domains**
3. Add your domain: `globelconnect.store`
4. Add www subdomain: `www.globelconnect.store`
5. Follow Vercel's instructions to update your DNS records

#### DNS Configuration:
Add these records to your domain registrar:

**For apex domain (globelconnect.store):**
```
Type: A
Name: @
Value: 76.76.21.21
```

**For www subdomain:**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

**Note:** DNS propagation can take up to 48 hours, but usually completes within a few hours.

## 🔧 Local Development

To run the application locally:

```bash
# Start development server
npm run dev
```

The application will be available at `http://localhost:3000`

## 🏪 Store Configuration

After deployment, configure your store settings:

1. Access the admin panel: `https://globelconnect.store/admin`
2. Login with your admin credentials
3. Navigate to **Settings** → **Store Settings**
4. Configure:
   - Store Name: "Globel Connect Store"
   - Store Email: info@globelconnect.store
   - Store Phone
   - Store Address
   - Currency, Timezone, etc.

## 🔒 Security Considerations

1. **Session Secret**: Generate a strong random string (min 32 characters)
   ```bash
   node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
   ```

2. **Database Password**: Use a strong, unique password

3. **Environment Variables**: Never commit `.env` file to version control

4. **HTTPS**: The configuration enforces HTTPS in production

5. **Security Headers**: Configured in `vercel.json`:
   - X-Content-Type-Options: nosniff
   - X-Frame-Options: DENY
   - X-XSS-Protection: 1; mode=block
   - Strict-Transport-Security (HSTS)

## 📊 Monitoring and Logs

- **Vercel Dashboard**: Monitor deployments, view logs, and check analytics
- **Database Logs**: Check your PostgreSQL provider's dashboard
- **Application Logs**: Available in Vercel's Functions logs

## 🐛 Troubleshooting

### Build Fails
- Check that all environment variables are set correctly
- Verify database connection details
- Review build logs in Vercel dashboard

### Database Connection Issues
- Verify database host is accessible from Vercel
- Check SSL settings if required by your database provider
- Ensure database user has proper permissions

### Domain Not Working
- Verify DNS records are correctly configured
- Wait for DNS propagation (up to 48 hours)
- Check domain configuration in Vercel dashboard
- Ensure SSL certificate is issued (automatic in Vercel)

### 404 Errors
- Check routing configuration in `vercel.json`
- Verify build completed successfully
- Clear browser cache

## 📚 Additional Resources

- [EverShop Documentation](https://evershop.io/docs)
- [Vercel Documentation](https://vercel.com/docs)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🆘 Support

For issues specific to:
- **EverShop**: [GitHub Issues](https://github.com/evershopcommerce/evershop/issues)
- **Vercel**: [Vercel Support](https://vercel.com/support)
- **Domain**: Contact your domain registrar

## ✅ Checklist

Before going live, ensure:

- [ ] Database is set up and accessible
- [ ] All environment variables are configured in Vercel
- [ ] Database migrations have been run
- [ ] Domain DNS records are configured
- [ ] SSL certificate is active (automatic in Vercel)
- [ ] Store settings are configured in admin panel
- [ ] Test checkout process
- [ ] Configure payment gateways
- [ ] Set up email notifications
- [ ] Test on multiple devices and browsers
- [ ] Set up monitoring and analytics

---

**Domain**: globelconnect.store  
**Platform**: EverShop on Vercel  
**Last Updated**: November 4, 2025
