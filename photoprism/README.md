# Solução de Auto-Hospedagem com Nextcloud e PhotoPrism

Este projeto demonstra uma solução completa de auto-hospedagem para gestão de arquivos e fotos, utilizando Docker Compose para orquestração de contêineres. O objetivo é fornecer uma infraestrutura escalável e privada para armazenamento em nuvem e organização de mídias, com PhotoPrism acessando os arquivos diretamente do volume do Nextcloud.

## Tecnologias Utilizadas:
- **Docker** & **Docker Compose**: Para conteinerização e orquestração de serviços.
- **Nextcloud**: Plataforma de nuvem privada para sincronização de arquivos e colaboração.
- **PhotoPrism**: Aplicação inteligente de gestão de fotos com IA, que indexa e organiza mídias.
- **MariaDB/PostgreSQL**: Bancos de dados para persistência de dados de ambas as aplicações.
- **Linux**: Sistema operacional base do servidor.

## Funcionalidades Principais:
- **Gerenciamento de Arquivos**: Sincronize e acesse seus arquivos de qualquer lugar com Nextcloud.
- **Organização de Fotos com IA**: Classificação, busca e organização automática de fotos e vídeos com PhotoPrism.
- **Compartilhamento de Dados**: PhotoPrism acessa a pasta de fotos do Nextcloud, evitando duplicação de dados e otimizando o armazenamento.
- **Ambiente Contêinerizado**: Fácil implantação e gerenciamento de dependências.

## Configuração e Implantação:

1.  **Pré-requisitos:**
    - Docker e Docker Compose instalados no seu servidor Linux.
    - Porta `80/443` (para web) e outras portas necessárias (se houver) disponíveis.

2.  **Estrutura de Pastas (Exemplo):**
    ```
    .
    ├── docker-compose.yml
    ├── .gitignore
    └── README.md
    └── # Outras pastas de configuração personalizadas (se houver, ex: nextcloud/config, photoprism/config)
    ```
    *Crie uma estrutura semelhante à sua, mas **não inclua** suas pastas `originals`, `database`, `cache`, `thumbs` ou `sync_data` aqui, pois elas contêm dados privados e devem ser ignoradas pelo Git.*

3.  **Arquivo `docker-compose.yml`:**
    Seu `docker-compose.yml` deve ser incluído aqui. Certifique-se de que os volumes para `originals`, `database`, `cache`, `thumbs` apontem para fora do repositório Git (ou seja, use `./data/photoprism-originals` em vez de `./originals` se quiser manter os dados fora da raiz do projeto, por exemplo, mas o importante é que eles estejam no `.gitignore`).
    **Remova quaisquer senhas ou informações sensíveis** diretamente do `docker-compose.yml` se elas estiverem hardcoded. Use variáveis de ambiente (`${VARIAVEL}`) e explique que elas devem ser definidas em um arquivo `.env` local (que está no `.gitignore`).

    ```yaml
    # Exemplo simplificado, substitua pelo seu docker-compose.yml real

	services:
      db:
        image: mariadb:10.6
        restart: unless-stopped
        environment:
          MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
          MYSQL_DATABASE: photoprism
          MYSQL_USER: photoprism
          MYSQL_PASSWORD: ${MYSQL_PASSWORD}
        volumes:
          - ./database/mysql:/var/lib/mysql

      photoprism:
        image: photoprism/photoprism:latest
        restart: unless-stopped
        depends_on:
          - db
        ports:
          - "2342:2342"
        environment:
          PHOTOPRISM_DATABASE_DRIVER: mysql
          PHOTOPRISM_DATABASE_DSN: "photoprism:${MYSQL_PASSWORD}@tcp(db:3306)/photoprism?parseTime=true"
          PHOTOPRISM_ADMIN_USER: ${PHOTOPRISM_ADMIN_USER}
          PHOTOPRISM_ADMIN_PASSWORD: ${PHOTOPRISM_ADMIN_PASSWORD}
          # ... outras variáveis de ambiente
        volumes:
          - /home/local/das/fotos:/photoprism/originals # Substitua /home/local/das/fotos para a pasta onde se encontram os arquivos
          - ./photoprism/storage:/photoprism/storage # Ajuste o caminho se for diferente
          - ./photoprism/cache:/photoprism/cache
          - ./photoprism/thumbs:/photoprism/thumbs

      # Adicione o serviço do Nextcloud aqui
      nextcloud:
        image: nextcloud:latest
        restart: unless-stopped
        ports:
          - "8080:80" # Ou a porta que você usa para o Nextcloud
        environment:
          MYSQL_DATABASE: ${NEXTCLOUD_DB_NAME}
          MYSQL_USER: ${NEXTCLOUD_DB_USER}
          MYSQL_PASSWORD: ${NEXTCLOUD_DB_PASSWORD}
          MYSQL_HOST: db # Se o Nextcloud usar o mesmo DB do PhotoPrism, ou crie um novo serviço de DB
        volumes:
          - ./nextcloud/html:/var/www/html
          - /home/syncthing_user/sync_data/celular_fotos/fotos/ALL_PHOTOS:/var/www/html/data/user/files/Photos # Exemplo de montagem da mesma pasta para o Nextcloud
    ```
4.  **Iniciar os Serviços:**
    ```bash
    docker compose up -d
    ```
    (Adicione quaisquer instruções adicionais de configuração pós-instalação para Nextcloud ou PhotoPrism, como a primeira inicialização ou criação de usuário admin.)

## O que este projeto demonstra para o meu currículo?
- **Habilidade com Docker e Contêineres:** Criação, configuração e orquestração de ambientes com Docker Compose.
- **Administração de Sistemas Linux:** Configuração de volumes, permissões e gerenciamento de serviços.
- **Soluções de Auto-Hospedagem:** Conhecimento em implantação e manutenção de aplicações open-source para infraestrutura pessoal/pequenas empresas.
- **Gerenciamento de Dados:** Estratégias para organização e acesso a grandes volumes de dados (fotos, arquivos) em diferentes aplicações.
- **Resolução de Problemas:** (Opcional, você pode mencionar brevemente desafios superados, como a questão das extensões de arquivo que você resolveu!)
- **Privacidade e Segurança:** Ênfase em soluções controladas pelo usuário.
