# Quick Start: globelconnect.store

## 🎯 What's Been Configured

Your EverShop store is now configured for the domain **globelconnect.store** with all necessary files in place.

## 📁 Files Created

```
/vercel/sandbox/
├── config/
│   ├── default.json          # Development configuration
│   └── production.json        # Production config with globelconnect.store
├── vercel.json                # Vercel deployment configuration
├── .env.example               # Environment variables template
├── DOMAIN_SETUP.md            # Complete setup guide
└── QUICK_START.md             # This file
```

## ⚡ Quick Deploy

### 1. Set Up Environment Variables
```bash
cp .env.example .env
# Edit .env with your database credentials
```

### 2. Install & Setup
```bash
npm install
npm run setup    # Run database migrations
npm run build    # Build the application
```

### 3. Deploy to Vercel
```bash
npm i -g vercel
vercel login
vercel --prod
```

### 4. Configure Domain
In Vercel Dashboard:
- Add domain: `globelconnect.store`
- Add domain: `www.globelconnect.store`
- Update DNS records as instructed

## 🔑 Required Environment Variables (Vercel)

Add these in Vercel Dashboard → Settings → Environment Variables:

```
NODE_ENV=production
DB_HOST=your-database-host
DB_PORT=5432
DB_NAME=evershop
DB_USER=your-db-user
DB_PASSWORD=your-secure-password
SESSION_SECRET=your-32-char-secret
```

## 🌐 DNS Configuration

Add to your domain registrar:

**A Record (apex domain):**
```
Type: A
Name: @
Value: 76.76.21.21
```

**CNAME Record (www):**
```
Type: CNAME
Name: www
Value: cname.vercel-dns.com
```

## 📖 Full Documentation

See [DOMAIN_SETUP.md](./DOMAIN_SETUP.md) for complete setup instructions, troubleshooting, and security best practices.

## ✅ Next Steps

1. ✅ Configuration files created
2. ⏳ Set up PostgreSQL database
3. ⏳ Configure environment variables
4. ⏳ Deploy to Vercel
5. ⏳ Configure DNS records
6. ⏳ Set up store in admin panel

---

**Need Help?** Check [DOMAIN_SETUP.md](./DOMAIN_SETUP.md) for detailed instructions.
