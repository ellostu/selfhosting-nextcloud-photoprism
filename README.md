# Self-Hosting Solution with Nextcloud and PhotoPrism (Docker Compose)

This project demonstrates a robust self-hosting infrastructure for file and photo management, orchestrated with Docker Compose. The focus is on efficient integration between Nextcloud for cloud storage and PhotoPrism for media organization, utilizing shared volumes to optimize space usage and ensure data integrity.

---

## 🚀 Technologies Used

* **Docker & Docker Compose**: Containerization and service orchestration for flexible deployment and management.
* **Nextcloud**: Private cloud platform for file synchronization, collaboration, and secure remote access.
* **PhotoPrism**: Intelligent photo management application that uses artificial intelligence for organizing, searching, and cataloging media.
* **MariaDB/PostgreSQL**: Relational databases used for data persistence for both applications (depending on your configuration).
* **Linux**: The base server operating system where the solution is deployed.
* **Nginx** (via `nginx.conf`): Web server/reverse proxy for Nextcloud, ensuring secure and efficient access (if applicable to your configuration).

---

## ✨ Key Features

* **Centralized File Management**: Synchronize and access your files from any device with Nextcloud.
* **Intelligent Photo Organization**: PhotoPrism automatically indexes and organizes photos and videos, enabling advanced searches and easy navigation.
* **Optimized Data Sharing**: Both applications access the **same media folder** on the host file system, eliminating data duplication and optimizing storage.
* **Containerized Environment**: Facilitates deployment, portability, and service isolation, ensuring a consistent environment.
* **Total Data Control**: Maintain privacy and control over your files by hosting them on your own infrastructure.

---

## 🛠️ Configuration and Deployment

To configure and start the solution, follow the steps below. Ensure Docker and Docker Compose are installed on your Linux server.

1.  **Clone the Repository:**
    ```bash
    git clone git clone https://github.com/ellostu/selfhosting-nextcloud-photoprism.git
    cd selfhosting-nextcloud-photoprism
    ```

2.  **Environment Variables:**
    Create `.env` files inside the `photoprism/` and `nextcloud/` folders for your sensitive environment variables (database passwords, admin users, etc.). These files are ignored by Git for security.

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
    *Adjust variable names and values according to your actual configuration and the requirements of your `docker-compose.yml` files.*

3.  **Shared Volume Configuration:**
    In your `docker-compose.yml` files, ensure that the folder where your actual photos are stored is mounted as a volume in **both** the Nextcloud and PhotoPrism services.

    **Example in `photoprism/docker-compose.yml` (within the `volumes` section of the `photoprism` service):**
    ```yaml
    volumes:
      - /your/photos/path:/photoprism/originals # Path to your photos
      # ... other PhotoPrism volumes
    ```

    **Example in `nextcloud/docker-compose.yml` (within the `volumes` section of the `app` or `nextcloud` service):**
    ```yaml
    volumes:
      - /your/photos/path:/var/www/html/data/YOUR_USERNAME/files/Photos # Example mounting for a specific user
      # OR, if mapping the folder directly to Nextcloud's data:
      # - /your/photos/path:/var/www/html/data/user/files/Photos
      # ... other Nextcloud volumes
    ```
    *Adjust the path `/var/www/html/data/YOUR_USERNAME/files/Photos` to reflect how you've configured Nextcloud to access this folder. It might differ depending on your version or "External Storages" configuration.*

4.  **Start the Services:**
    Navigate to each service folder and start them:

    ```bash
    cd photoprism
    docker compose up --build --pull always --wait
    cd ../nextcloud
    docker compose up --build --pull always --waitd
    ```

5.  **Post-Installation Configuration:**
    * Access the web interfaces of Nextcloud and PhotoPrism through their configured ports (e.g., `http://your_ip:8080` for Nextcloud and `http://your_ip:2342` for PhotoPrism).
    * Follow the instructions for initial setup (admin user creation, database connection, etc.).
    * In PhotoPrism, start the indexing process to discover your photos.

---

## 🔧 Utility Scripts

This project includes auxiliary scripts to address common challenges in managing large media collections:

* **`photoprism/fix_image_extensions.sh`**:
    * **Purpose:** To tackle real-world data challenges, I've included `fix_image_extensions.sh`. This script was developed to resolve issues with mismatched file extensions and metadata, a common hurdle when integrating photos from external sources like Google Takeout.
    * **Demonstrates:** Ability to diagnose and solve metadata/file format problems, and automation of data management tasks.
    * **Adittional info:** You may need to change something according to the file types. Also, if you don`t have this kind of issue, feel free to not use this script at all or delete it.

---

---

## 🎯 What This Project Demonstrates

This project showcases a robust set of practical skills and expertise in cloud infrastructure and data management:

* **Containerization & Orchestration (Docker & Docker Compose):** Proficiently designed, configured, and managed complex, multi-service environments, ensuring efficient deployment and scalability.
* **Linux System Administration:** Applied strong command-line and system management skills for file handling, permissions, robust volume mounting, and resource optimization on a Linux server.
* **Self-Hosting & Open-Source Solutions:** Successfully planned, implemented, and maintained critical open-source applications (Nextcloud, PhotoPrism) for private cloud and media management, emphasizing user data control.
* **Complex System Integration:** Seamlessly integrated disparate applications (Nextcloud and PhotoPrism) to share a single media dataset via host-level volume mounts, optimizing storage and workflow efficiency.
* **Robust Data Management:** Demonstrated capability in handling and securing large volumes of media data efficiently, ensuring data integrity and accessibility across services.
* **Security & Privacy Best Practices:** Implemented self-controlled infrastructure with a strong focus on data privacy and security, including the secure handling of sensitive credentials via environment variables.
* **Advanced Problem-Solving & Scripting:**
    * **Proactive Issue Resolution:** Identified and systematically resolved complex infrastructure challenges, including **database performance tuning for MariaDB** and **web server configuration intricacies with Nginx** (and potential experience with Caddy if applicable).
    * **Data Integrity & Automation:** Developed and deployed custom shell scripts (e.g., `fix_image_extensions.sh`) utilizing tools like **ExifTool** to diagnose and programmatically correct real-world data issues such as inconsistent metadata and file extensions from third-party sources (e.g., Google Takeout). This highlights initiative in automating solutions for data quality.

