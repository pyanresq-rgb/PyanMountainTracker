# Deployment Guide - PyanMountainTracker

## Production Deployment

### 1. Environment Setup

Setup production environment variables:

```bash
# backend/.env
NODE_ENV=production
PORT=3000
DATABASE_URL=postgresql://user:password@prod-db:5432/pyan_tracker
JWT_SECRET=very_secure_secret_key_here
JWT_EXPIRE=24h
```

### 2. Database Migrations

```bash
# Run migrations
psql $DATABASE_URL -f database/init.sql
```

### 3. Docker Build

```bash
# Build all images
docker build -t pyan-backend:latest ./backend
docker build -t pyan-dashboard:latest ./dashboard
```

### 4. Deploy Options

#### Option A: Docker Swarm

```bash
docker stack deploy -c docker-compose.yml pyan
```

#### Option B: Kubernetes

```bash
kubectl apply -f k8s/
```

#### Option C: Cloud Platform

- **Heroku:** `git push heroku main`
- **Railway:** Connect GitHub repo
- **Render:** Auto-deploy from GitHub
- **AWS ECS:** Push to ECR registry

### 5. SSL/TLS Certificate

```bash
# Using Let's Encrypt with nginx
certbot certonly --nginx -d yourdomain.com
```

### 6. Monitoring

- PM2 untuk process management
- Datadog/New Relic untuk monitoring
- CloudFlare untuk DDoS protection

### 7. Backup Strategy

```bash
# Daily database backup
0 2 * * * pg_dump $DATABASE_URL | gzip > /backups/db_$(date +%Y%m%d).sql.gz
```

## Performance Optimization

- Enable Redis caching
- Setup CDN untuk assets
- Database indexing
- API rate limiting
- Load balancing

## Security Checklist

- ✅ HTTPS enabled
- ✅ Strong JWT secret
- ✅ Database password protected
- ✅ Input validation
- ✅ CORS configured
- ✅ Rate limiting active
- ✅ Security headers set
- ✅ Regular backups

## Troubleshooting

### Database Connection Failed
```bash
# Check database
psql -U user -d database_name -c "SELECT 1"
```

### High Memory Usage
```bash
# Monitor Node.js process
node --max-old-space-size=4096 server.js
```

### Socket.io Connection Issues
```bash
# Check firewall & ports
sudo ufw allow 3000
```
