# Solução de Auto-Hospedagem com Nextcloud e PhotoPrism (Docker Compose)

Este projeto demonstra uma infraestrutura robusta de auto-hospedagem para gerenciamento de arquivos e fotos, orquestrada com Docker Compose. O foco está na integração eficiente entre o Nextcloud para armazenamento em nuvem e o PhotoPrism para organização de mídias, utilizando volumes compartilhados para otimizar o uso do espaço e garantir a integridade dos dados.

---

## 🚀 Tecnologias Utilizadas

* **Docker & Docker Compose**: Conteinerização e orquestração de serviços para implantação e gerenciamento flexíveis.
* **Nextcloud**: Plataforma de nuvem privada para sincronização de arquivos, colaboração e acesso remoto seguro.
* **PhotoPrism**: Aplicação inteligente de gestão de fotos, que utiliza inteligência artificial para organização, busca e catalogação de mídias.
* **MariaDB/PostgreSQL**: Bancos de dados relacionais utilizados para persistência de dados de ambas as aplicações (dependendo da sua configuração).
* **Linux**: Sistema operacional base do servidor, onde a solução é implantada.
* **Nginx** (via `nginx.conf`): Servidor web/proxy reverso para o Nextcloud, garantindo acesso seguro e eficiente (se aplicável à sua configuração).

---

## ✨ Funcionalidades Principais

* **Gerenciamento Centralizado de Arquivos**: Sincronize e acesse seus arquivos de qualquer dispositivo com o Nextcloud.
* **Organização Inteligente de Fotos**: O PhotoPrism indexa e organiza fotos e vídeos automaticamente, permitindo buscas avançadas e fácil navegação.
* **Compartilhamento Otimizado de Dados**: Ambas as aplicações acessam a **mesma pasta de mídias** no sistema de arquivos do host, eliminando a duplicação de dados e otimizando o armazenamento.
* **Ambiente Contêinerizado**: Facilita a implantação, portabilidade e isolamento dos serviços, garantindo um ambiente consistente.
* **Controle Total dos Dados**: Mantenha a privacidade e o controle sobre seus arquivos, hospedando-os em sua própria infraestrutura.

---

## 🛠️ Configuração e Implantação

Para configurar e iniciar a solução, siga os passos abaixo. Certifique-se de que o Docker e o Docker Compose estejam instalados no seu servidor Linux.

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/ellostu/selfhosting-nextcloud-photoprism.git
    cd selfhosting-nextcloud-photoprism
    ```

2.  **Variáveis de Ambiente:**
    Crie arquivos `.env` dentro das pastas `photoprism/` e `nextcloud/` para suas variáveis de ambiente sensíveis (senhas de banco de dados, usuários admin, etc.). Estes arquivos são ignorados pelo Git por segurança.

    **Exemplo de `photoprism/.env`:**
    ```
    MYSQL_ROOT_PASSWORD=sua_senha_root_db_photoprism
    MYSQL_DATABASE=photoprism_db
    MYSQL_USER=photoprism_user
    MYSQL_PASSWORD=sua_senha_photoprism_db
    PHOTOPRISM_ADMIN_USER=admin_photoprism
    PHOTOPRISM_ADMIN_PASSWORD=sua_senha_admin_photoprism
    ```

    **Exemplo de `nextcloud/.env`:**
    ```
    MYSQL_ROOT_PASSWORD=sua_senha_root_db_nextcloud
    MYSQL_DATABASE=nextcloud_db
    MYSQL_USER=nextcloud_user
    MYSQL_PASSWORD=sua_senha_nextcloud_db
    ```
    *Ajuste os nomes das variáveis e os valores conforme sua configuração real e os requisitos dos `docker-compose.yml`.*

3.  **Configuração de Volumes Compartilhados:**
    No seus arquivos `docker-compose.yml`, certifique-se de que a pasta onde suas fotos reais estão armazenadas (`/home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS` no seu caso) esteja montada como um volume em **ambos** os serviços Nextcloud e PhotoPrism.

    **Exemplo no `photoprism/docker-compose.yml` (seção `volumes` do serviço `photoprism`):**
    ```yaml
    volumes:
      - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/photoprism/originals # Caminho das suas fotos
      # ... outros volumes do PhotoPrism
    ```

    **Exemplo no `nextcloud/docker-compose.yml` (seção `volumes` do serviço `app` ou `nextcloud`):**
    ```yaml
    volumes:
      - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/var/www/html/data/SEU_USUARIO/files/Photos # Exemplo de montagem para um usuário específico
      # OU, se mapear a pasta diretamente para o data do Nextcloud:
      # - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/var/www/html/data/user/files/Photos
      # ... outros volumes do Nextcloud
    ```
    *Ajuste o caminho `/var/www/html/data/SEU_USUARIO/files/Photos` para refletir como você configurou o Nextcloud para acessar essa pasta. Pode ser diferente dependendo da sua versão ou configuração de "External Storages".*

4.  **Iniciar os Serviços:**
    Navegue até cada pasta de serviço e inicie-os:

    ```bash
    cd photoprism
    docker compose up -d --build # Use --build se fez alterações nos Dockerfiles ou --force-recreate se quer recriar os containers
    cd ../nextcloud
    docker compose up -d --build
    ```

5.  **Configuração Pós-Instalação:**
    * Acesse as interfaces web do Nextcloud e PhotoPrism através das portas configuradas (ex: `http://seu_ip:8080` para Nextcloud e `http://seu_ip:2342` para PhotoPrism).
    * Siga as instruções para a primeira configuração (criação de usuário admin, conexão com banco de dados, etc.).
    * No PhotoPrism, inicie a indexação para que ele descubra suas fotos.

---

## 🎯 O que este Projeto Demonstra

Este projeto destaca as seguintes habilidades e conhecimentos:

* **Conteinerização e Orquestração (Docker & Docker Compose)**: Proficiência na criação, configuração e gerenciamento de ambientes complexos e multi-serviços.
* **Administração de Sistemas Linux**: Experiência com gerenciamento de arquivos, permissões, montagem de volumes e otimização de recursos em um ambiente Linux.
* **Soluções de Auto-Hospedagem**: Capacidade de planejar, implementar e manter aplicações de código aberto para necessidades de infraestrutura pessoal ou de pequenas empresas.
* **Integração de Sistemas**: Habilidade em conectar diferentes aplicações (Nextcloud e PhotoPrism) para compartilhar dados e otimizar fluxos de trabalho.
* **Gerenciamento de Dados**: Conhecimento em lidar com grandes volumes de dados de mídia de forma eficiente e segura.
* **Segurança e Privacidade**: Preocupação com a segurança dos dados pessoais através do controle da própria infraestrutura e uso adequado de variáveis de ambiente.
* **Resolução de Problemas**: (Opcional: Você pode adicionar uma pequena seção aqui ou no seu currículo sobre como resolveu o problema da "extensão inválida para o tipo de mídia", mostrando sua capacidade de depuração e diagnóstico.)

---
