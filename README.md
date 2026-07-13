# PyanMountainTracker

Real-time GPS tracking app untuk hikers di hutan. Membantu tracking posisi hikers, emergency alerts, dan trail history.

## 🎯 Misi

**Track Together • Stay Safe** - Membuat hiking lebih aman dengan real-time tracking dan emergency alerts.

## 📱 Tech Stack

- **Mobile:** Flutter (Android & iOS)
- **Backend:** Node.js + Express
- **Database:** PostgreSQL
- **Dashboard:** React
- **Real-time:** Socket.io
- **Maps:** Google Maps / Mapbox

## 🏔️ Project Structure

```
PyanMountainTracker/
├── mobile_app/              # Flutter mobile application
│   ├── android/             # Android native code
│   ├── ios/                 # iOS native code
│   ├── lib/
│   │   ├── main.dart
│   │   ├── app.dart
│   │   ├── config/          # Configuration files
│   │   ├── models/          # Data models
│   │   ├── services/        # API & socket services
│   │   ├── providers/       # State management
│   │   ├── routes/          # Navigation routes
│   │   ├── widgets/         # Reusable widgets
│   │   └── screens/         # App screens
│   │       ├── splash/
│   │       ├── login/
│   │       ├── register/
│   │       ├── home/
│   │       ├── map/
│   │       ├── group/
│   │       ├── sos/
│   │       ├── history/
│   │       └── profile/
│   ├── assets/
│   │   ├── logo/
│   │   └── images/
│   └── pubspec.yaml
│
├── backend/                 # Node.js + Express API
│   ├── src/
│   │   ├── server.js
│   │   ├── config/
│   │   │   └── database.js
│   │   ├── routes/
│   │   │   ├── auth.js
│   │   │   ├── users.js
│   │   │   ├── tracking.js
│   │   │   ├── groups.js
│   │   │   └── sos.js
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── middleware/
│   │   └── utils/
│   ├── tests/
│   ├── .env.example
│   ├── package.json
│   ├── Dockerfile
│   └── .dockerignore
│
├── dashboard/               # React admin dashboard
│   ├── public/
│   ├── src/
│   │   ├── pages/
│   │   ├── components/
│   │   ├── services/
│   │   ├── App.js
│   │   └── index.js
│   ├── package.json
│   ├── Dockerfile
│   └── .dockerignore
│
├── database/                # Database
│   └── init.sql
│
├── docs/                    # Documentation
│   ├── SETUP.md
│   ├── API.md
│   └── DEPLOYMENT.md
│
├── docker-compose.yml
├── .gitignore
├── .github/
│   └── workflows/
│       └── test.yml
└── README.md
```

## ✨ Fitur Utama

- ✅ **Real-time GPS Tracking** - Track posisi hikers secara live
- ✅ **Live Map Visualization** - Visualisasi posisi di maps
- ✅ **Group Management** - Buat dan kelola grup hiking
- ✅ **SOS/Emergency Alerts** - Alert emergency ke group members
- ✅ **Trail History** - Riwayat trek yang sudah dilakukan
- ✅ **User Authentication** - Login/register yang aman
- ✅ **Admin Dashboard** - Monitoring dan management
- ✅ **Offline Mode** - Cache data saat offline

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Flutter 3.0+
- PostgreSQL 14+
- Docker (optional)

### Setup dengan Docker Compose

```bash
# Clone repository
git clone https://github.com/pyanresq-rgb/PyanMountainTracker.git
cd PyanMountainTracker

# Start all services
docker-compose up -d
```

Services akan running:
- **Backend API:** http://localhost:3000
- **Dashboard:** http://localhost:3001
- **PostgreSQL:** localhost:5432

### Setup Manual

Lihat `docs/SETUP.md` untuk instruksi lengkap.

## 📚 Dokumentasi

- [Setup Guide](docs/SETUP.md) - Panduan instalasi
- [API Documentation](docs/API.md) - Dokumentasi API endpoints
- [Deployment Guide](docs/DEPLOYMENT.md) - Deploy ke production

## 🔄 Real-time Updates

App menggunakan Socket.io untuk real-time tracking:

```javascript
// Bergabung dengan tracking group
socket.emit('join_tracking', { groupId: 1 });

// Update lokasi
socket.emit('update_location', {
  groupId: 1,
  latitude: 6.2088,
  longitude: 106.8456
});

// Listen for updates
socket.on('location_updated', (data) => {
  // Handle location update
});
```

## 🛡️ Security

- JWT authentication untuk semua endpoints
- Password hashing dengan bcryptjs
- HTTPS/SSL untuk production
- Database encryption
- Rate limiting

## 👥 Contributing

Contributions welcome! Silakan:

1. Fork repository
2. Buat feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📝 License

MIT License - lihat [LICENSE](LICENSE) file untuk details.

## 📞 Contact

- GitHub: [@pyanresq-rgb](https://github.com/pyanresq-rgb)
- Issues: [GitHub Issues](https://github.com/pyanresq-rgb/PyanMountainTracker/issues)

---

**Made with ❤️ for safer hiking adventures** 🏔️
