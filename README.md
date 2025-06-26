# ☁️ Self-Hosted Cloud & Photo Management – Nextcloud + Photoprism Stack

> Personal Infrastructure Project  
> Secure and private self-hosted cloud system using **Nextcloud**, **Photoprism**, **Docker**, and **Tailscale**.  
> Designed to manage personal files and photos across devices with full control over data, privacy, and uptime.  
> 🛠️ Entirely self-configured on Linux, using Docker Compose, persistent volumes, and network tunneling.

---

## 📦 Stack Overview

| Component     | Purpose                                      |
|---------------|----------------------------------------------|
| **Nextcloud** | Private file cloud, contacts, calendar, etc. |
| **Photoprism**| AI-powered photo manager and gallery         |
| **Docker**    | Container orchestration                      |
| **Tailscale** | Zero-config VPN access across devices        |
| **Caddy/Nginx (optional)** | Reverse proxy with HTTPS         |

---

## 🔧 Features

- 📁 **Secure cloud file storage** with full Nextcloud functionality
- 📸 **Private photo AI** tagging and search with Photoprism
- 🔐 **Access from anywhere** via Tailscale mesh VPN
- 🐳 **Containerized setup** via Docker Compose for isolation and portability
- 💾 **Persistent volumes** and configuration backups
- 🚀 **Fast restore and redeploy** (in case of failure or migration)

---

## 💡 What This Demonstrates

This project showcases skills relevant for **DevOps, systems engineering, and secure cloud operations**, including:

- 🧠 **Linux Server Configuration**
- ⚙️ **Docker & Container Orchestration**
- 📡 **Private Networking with Tailscale**
- 🛡️ **Security, Backups & Persistence**
- 🔁 **Automation of self-hosted infrastructure**

> Although built for personal use, this setup reflects real-world DevOps practices and systems thinking.

---

## 🏗️ Project Structure

```
.
├── docker-compose.yml
├── .env
├── tailscale/
│   └── authkey (optional secure setup)
├── nextcloud/
│   └── config, data volumes (binds or named)
├── photoprism/
│   └── storage, import, originals
└── README.md
```

---

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/ellostu/selfhosting-nextcloud-photoprism
   cd selfhosting-nextcloud-photoprism
   ```

2. Configure environment:
   - Edit `.env` with your preferred paths, passwords, and ports.

3. Start the services:
   ```bash
   docker compose up -d
   ```

4. Access your services:
   - Nextcloud: `https://your-device:port`
   - Photoprism: `https://your-device:port`
   - Or through Tailscale

---

## 🔐 Security Notes

- Uses Tailscale to avoid exposing ports to the public internet.
- SSL certificates can be added with Caddy or Nginx reverse proxy.
- Volumes are persistent and can be backed up using `rsync` or `borg`.

---

## 📚 Inspiration

- [Nextcloud](https://nextcloud.com/)
- [Photoprism](https://photoprism.app/)
- [Tailscale](https://tailscale.com/)
- [Docker](https://docs.docker.com/compose/)

---

## 📌 Relevance to Engineering & Internship Goals

This project demonstrates:

- **Autonomy and initiative** in designing and deploying secure, reliable infrastructure;
- **Hands-on experience with cloud-native tools**, relevant to areas like IoT, edge computing, and private network systems;
- A deep understanding of **system reliability, data ownership, and security**, applicable to real-world telecom and embedded environments;
- Ability to **learn and apply new technologies independently** — a key trait in fast-paced R&D teams like those at Ericsson.

---

## 📸 Preview (Optional)

> Add screenshots here of the dashboard, folders, Photoprism interface, or Tailscale dashboard to make it visual.

---

## 🧪 Future Improvements

- Add auto-backup routines
- Include a UI to manage services
- Integrate with mobile clients (Nextcloud App)
- Use Watchtower for auto-updates
- Add WireGuard + QR setup for alternative VPN method

---
