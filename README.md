# Bookmarks

* [Development environment setup](#development-environment-setup)
  * [Prerequisites](#prerequisites)
  * [config/application.yml file](#configapplicationyml-file)
  * [.env file](#env-file)
  * [Docker services management](#services-management)
  * [Run tests](#run-tests)

## Development environment setup

Docker has been used to provide portable setup for development regardless of operating system and its dependencies. Therefore, it is not necessary to install database servers or any other services locally - you just need to build prepared docker images locally.

Configuration steps ensure separation from the host and all process will happen inside the virtualized environment. Therefore, values within configuration files point either to containers or ports "visible" only inside the virtualized environment.

All Docker images and services for development and test environment are suffixed with `.local` in their names.

### Prerequisites
* Docker
* Docker-compose
* `config/application.yml` file
* `.env` file

### config/application.yml file
Environment variables for development and test environments are stored in `config/application.yml` and are managed by [Figaro gem](https://rubygems.org/gems/figaro). It makes them easily visible in runtime environment without any need of initialization.

Within application, can be easily accessed via `ENV` singleton.

**This file, under no circumstances should never be committed to the repository.**

Values (especially regarding databases) should point to specific containers, which are defined in `docker-compose.local.yml` file.

See example below for correct config - it should be filled in with username and password of your preference (not root).
```yaml
development:
  DB_NAME: bookmarks_development
  DB_POOL: "35"
  DB_USERNAME: <fill in with your username>
  DB_PASSWORD: <fill in with your password>
  DB_HOST: bookmarks_db_development
  DB_PORT: "5432"

test:
  DB_NAME: bookmarks_test
  DB_POOL: "35"
  DB_USERNAME: <fill in with your username>
  DB_PASSWORD: <fill in with your password>
  DB_HOST: bookmarks_db_test
  DB_PORT: "5432"
```

### .env file
`.env` file allows to configure services from `docker-compose.local.yml` to be run on ports of your choice. This is essential for ports mapping to make services available outside of virtualized containers.

See example below for correct config - `DB_USERNAME` and `DB_PASSWORD` values should correspond with values from [config/application.yml file](#configapplicationyml-file).

```dotenv
COMPOSE_FILE=docker-compose.local.yml
RAILS_PORT=3000
DEV_DB_PORT=5432
TEST_DB_PORT=5433
DB_USERNAME=<fill in with your username>
DB_PASSWORD=<fill in with your password>
```

### Services management
To initialize whole environment just run the following script:
```bash
sh bin/docker_init
```
Bash scripts allowing for management are placed in `bin` directory.

Containers do not need to be rebuilt after each change in codebase.

Useful commands for services management:
* `sh bin/docker_build` rebuilds images
* `sh bin/docker_start` starts services
* `sh bin/docker_stop` stops services
* `sh bin/docker_status` displays the current state of containers

### Run tests

```bash
sh bin/run_tests
```
