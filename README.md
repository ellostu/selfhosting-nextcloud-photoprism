# Self-Hosting Cloud and Media Management Solution (Docker Compose)

This project outlines a robust, self-hosted infrastructure for centralized file storage and intelligent photo management, meticulously orchestrated with Docker Compose. It showcases an efficient integration between Nextcloud for private cloud services and PhotoPrism for AI-powered media organization, leveraging shared volumes to optimize storage, enhance data integrity, and demonstrate operational resilience.

This solution, while personal in scale, exemplifies foundational principles applicable to building and managing reliable, scalable, and secure enterprise cloud environments.

---

## 🚀 Technologies Utilized

* **Docker & Docker Compose**: Core components for containerization and infrastructure-as-code (IaC) principles, enabling flexible deployment, service isolation, and consistent environments.
* **Nextcloud**: A leading open-source private cloud platform, providing secure file synchronization, sharing, and collaborative features.
* **PhotoPrism**: An AI-powered application for advanced photo and video management, featuring intelligent indexing, search capabilities, and automatic content organization.
* **MariaDB/PostgreSQL**: Robust relational databases serving as the persistent data stores for both Nextcloud and PhotoPrism, demonstrating competence in database management and configuration.
* **Linux**: The foundational server operating system, providing a stable and secure environment for container deployment and system administration tasks.
* **Nginx** (via `nginx.conf`): Configured as a high-performance web server and reverse proxy for Nextcloud, illustrating practical experience with traffic management, security headers, and efficient web service delivery. (If Caddy was used, consider adding "or Caddy for automated HTTPS and simplified configuration.")
* **Bash/Shell Scripting**: Employed for automating operational tasks, including custom solutions for data integrity and file management.
* **ExifTool**: Integrated into custom scripts for advanced metadata extraction and manipulation, critical for data quality and consistency.

---

## ✨ Key Features & Operational Highlights

* **Centralized & Secure File Management**: Implemented Nextcloud for robust file synchronization and access across devices, ensuring data sovereignty and control.
* **AI-Powered Media Organization**: Utilized PhotoPrism's AI capabilities for efficient indexing, tagging, and searching of media, streamlining large photo collections.
* **Optimized Data Orchestration**: Engineered a shared volume strategy that allows both Nextcloud and PhotoPrism to access the **same physical media files** on the host. This eliminates data duplication, optimizes storage utilization, and simplifies cross-application data management.
* **Containerized Service Deployment**: Deployed services within isolated Docker containers, enhancing portability, simplifying dependency management, and ensuring consistent application behavior across environments.
* **Operational Resilience & Performance**:
    * Configured services with `restart: always` for automatic recovery, contributing to high availability.
    * (Optional: If you re-add healthchecks) Incorporated Docker healthchecks to monitor service readiness and automatically manage unhealthy containers, crucial for maintaining service uptime.
    * Leveraged Redis for caching within Nextcloud, demonstrating an understanding of performance optimization techniques for web applications.
* **Security & Privacy by Design**: Emphasized self-controlled infrastructure for enhanced privacy. Ensured secure handling of sensitive credentials using environment variables (`.env` files ignored by Git).

---

## 🛠️ Configuration and Deployment

This section details the steps to set up and run the solution. Ensure Docker and Docker Compose are installed on your Linux server.

1.  **Clone the Repository:**
    ```bash
    git clone https://github.com/ellostu/selfhosting-nextcloud-photoprism.git
    cd selfhosting-nextcloud-photoprism
    ```

2.  **Environment Variables:**
    Create `.env` files within the `photoprism/` and `nextcloud/` directories to store sensitive environment variables (e.g., database passwords, admin credentials). These files are crucial for security and are deliberately excluded from Git tracking via `.gitignore`.

    **Example `photoprism/.env`:**
    ```
    MYSQL_ROOT_PASSWORD=your_photoprism_db_root_password
    MYSQL_DATABASE=photoprism_db
    MYSQL_USER=photoprism_user
    MYSQL_PASSWORD=your_photoprism_db_password
    PHOTOPRISM_ADMIN_USER=admin_photoprism
    PHOTOPRISM_ADMIN_PASSWORD=your_photoprism_admin_password
    ```

    **Example `nextcloud/.env`:**
    ```
    MYSQL_ROOT_PASSWORD=your_nextcloud_db_root_password
    MYSQL_DATABASE=nextcloud_db
    MYSQL_USER=nextcloud_user
    MYSQL_PASSWORD=your_nextcloud_db_password
    ```
    *Adjust variable names and values to match your specific `docker-compose.yml` configurations and security best practices.*

3.  **Shared Volume Configuration:**
    Ensure the absolute path to your media files on the host system (e.g., `/home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS`) is consistently mounted as a volume in both Nextcloud and PhotoPrism's `docker-compose.yml` files. This establishes the shared data layer.

    **Example in `photoprism/docker-compose.yml` (within the `volumes` section of the `photoprism` service):**
    ```yaml
    volumes:
      - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/photoprism/originals # Host path to your photos
      # ... other PhotoPrism volumes
    ```

    **Example in `nextcloud/docker-compose.yml` (within the `volumes` section of the `app` or `nextcloud` service):**
    ```yaml
    volumes:
      - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/var/www/html/data/YOUR_USERNAME/files/Photos # Host path mapped for a specific Nextcloud user
      # OR, for external storage configuration:
      # - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/mnt/external_photos
      # ... other Nextcloud volumes
    ```
    *Note: The exact path within the Nextcloud container (`/var/www/html/data/...`) depends on your Nextcloud setup (e.g., direct user folder mount or external storage configuration).*

4.  **Start the Services:**
    Navigate to each service directory and launch the containers. Using `--pull always` ensures the latest images are used, and `--wait` (if available on your Docker Compose version) enhances deployment reliability by waiting for services to be healthy.

    ```bash
    cd photoprism
    docker compose up -d --build --pull always --wait
    cd ../nextcloud
    docker compose up -d --build --pull always --wait
    ```

5.  **Post-Installation & Access:**
    * Access the web interfaces of Nextcloud and PhotoPrism via their configured ports (e.g., `http://your_server_ip:8080` for Nextcloud and `http://your_server_ip:2342` for PhotoPrism).
    * Complete any initial setup steps (e.g., admin user creation, database connection verification).
    * Initiate indexing in PhotoPrism to discover and catalog your media files.

---

## 🔧 Utility Scripts

This project includes auxiliary scripts developed to address specific operational and data management challenges:

* **`photoprism/fix_image_extensions.sh`**:
    * **Purpose:** To tackle real-world data challenges, I've included `fix_image_extensions.sh`. This script was developed to resolve issues with mismatched file extensions and internal metadata (e.g., a `.HEIC` file internally identified as `image/jpeg`), a common hurdle when integrating photo collections from external sources like Google Takeout.
    * **Demonstrates:** Proactive problem-solving, data quality assurance, and the ability to automate complex data correction tasks using shell scripting and `ExifTool`.

---

## 🎯 What This Project Demonstrates

This project showcases a robust set of practical skills and expertise in cloud infrastructure, data management, and operational excellence, highly relevant for roles at Ericsson:

* **Containerization & Orchestration (Docker & Docker Compose):** Proficiently designed, configured, and managed complex, multi-service containerized environments. Demonstrated expertise in `docker-compose` for robust deployment, service isolation, and maintaining consistent application states, adhering to **Infrastructure as Code (IaC)** principles.
* **Linux System Administration:** Applied strong command-line and system management skills for secure file handling, precise volume management, and optimized resource utilization on a Linux server. Experience with **UFW firewall configuration** for network security.
* **Self-Hosting & Open-Source Solutions:** Successfully planned, implemented, and maintained critical open-source applications (Nextcloud, PhotoPrism), showcasing end-to-end ownership of infrastructure and software lifecycle.
* **Complex System Integration & Networking:** Seamlessly integrated disparate applications (Nextcloud and PhotoPrism) via host-level volume mounts, establishing efficient data pipelines. Gained hands-on experience with **Nginx as a reverse proxy** for secure and efficient application exposure, understanding fundamental networking concepts within a Dockerized environment.
* **Database Management & Performance (MariaDB/PostgreSQL):** Configured and troubleshoot relational databases, including specific **MariaDB optimization flags** and initial database initialization, highlighting an understanding of database reliability and performance.
* **Operational Excellence & Reliability:** Implemented strategies for service resilience (e.g., `restart: always`, and ideally Docker healthchecks) to ensure high availability and automatic recovery, demonstrating a focus on service reliability and uptime.
* **Advanced Problem-Solving & Data Integrity:**
    * **Proactive Diagnostics:** Demonstrated the ability to systematically diagnose intricate infrastructure issues (e.g., `connection refused` errors, database initialization failures, `WARN index` inconsistencies) and iteratively apply solutions.
    * **Data Quality Automation:** Developed custom shell scripts leveraging tools like `ExifTool` to automate the detection and correction of critical data integrity issues (e.g., mismatched file extensions/metadata), a common challenge in large-scale data ingestion. This highlights a commitment to data quality and efficiency.
* **Security & Privacy Best Practices:** Implemented secure credential management via `.env` files and `gitignore`, emphasizing a strong commitment to data privacy and operational security.

---

### 💡 Future Enhancements (Demonstrating Continuous Learning & Proactiveness)

* **Automated HTTPS**: Integrate a Certbot container (e.g., with Nginx) for automatic TLS certificate management using Let's Encrypt.
* **Centralized Logging**: Implement a logging solution (e.g., ELK stack or Grafana Loki) for consolidated log aggregation and analysis.
* **Monitoring & Alerting**: Integrate Prometheus and Grafana to monitor container health, resource utilization, and application-specific metrics.
* **CI/CD Pipeline**: Automate deployment and updates of the Docker Compose services using a simple CI/CD pipeline (e.g., GitHub Actions).
* **Advanced Networking**: Implement custom Docker bridge networks or explore overlay networks for multi-host deployments.
* **Upgrade to Kubernetes**: (For highly ambitious candidates) Migrate the Docker Compose setup to a Kubernetes cluster to demonstrate orchestration at scale.
