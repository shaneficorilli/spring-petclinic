# Spring PetClinic [![Build Status](https://github.com/shaneficorilli/spring-petclinic/actions/workflows/maven-build.yml/badge.svg)](https://github.com/shaneficorilli/spring-petclinic/actions/workflows/maven-build.yml) [![Scanned by Frogbot](https://raw.github.com/jfrog/frogbot/master/images/frogbot-badge.svg)](https://docs.jfrog-applications.jfrog.io/jfrog-applications/frogbot)

## Overview

This repository contains a forked version of the [spring-petclinic](https://github.com/spring-projects/spring-petclinic) java project. Included are GitHub actions that provide CI to: 

- Run included integration tests
- Build the project executable (.jar) using [Maven](https://maven.apache.org/) and upload as a GitHub build artifact
- Create and run SAST and dependency scans using [CodeQL](https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning-with-codeql), [Dependabot](https://docs.github.com/en/code-security/dependabot/dependabot-security-updates/configuring-dependabot-security-updates), and [JFrog Frogbot](https://docs.jfrog-applications.jfrog.io/jfrog-applications/frogbot)
- Build a runnable Docker image and push to [Dockerhub](https://hub.docker.com/) and [JFrog Artifactory](https://jfrog.com/help/r/jfrog-artifactory-documentation)

## Build and pull the container image

The Dockerfile for this forked version of PetClinic uses GitHub actions to build and push a Docker image to both Dockerhub and to an instance of JFrog Artifactory.

The following command can be used to pull the image from Dockerhub:

``` docker pull stfi/spring-petclinic:latest ```

## Run the container image locally

Once the container image has been successfully pulled, use the following command to run it locally:

``` docker run -p 8080:8080 stfi/spring-petclinic:latest ```

### Database configuration

In its default configuration, Petclinic uses an in-memory database (H2) which
gets populated at startup with data. The h2 console is exposed at `http://localhost:8080/h2-console`,
and it is possible to inspect the content of the database using the `jdbc:h2:mem:<uuid>` URL. The UUID is printed at startup to the console.

A similar setup is provided for MySQL and PostgreSQL if a persistent database configuration is needed. Note that whenever the database type changes, the app needs to run with a different profile: `spring.profiles.active=mysql` for MySQL or `spring.profiles.active=postgres` for PostgreSQL. See the [Spring Boot documentation](https://docs.spring.io/spring-boot/how-to/properties-and-configuration.html#howto.properties-and-configuration.set-active-spring-profiles) for more detail on how to set the active profile.

You can start MySQL or PostgreSQL locally with whatever installer works for your OS or use docker:

```bash
docker run -e MYSQL_USER=petclinic -e MYSQL_PASSWORD=petclinic -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=petclinic -p 3306:3306 mysql:8.4
```

or

```bash
docker run -e POSTGRES_USER=petclinic -e POSTGRES_PASSWORD=petclinic -e POSTGRES_DB=petclinic -p 5432:5432 postgres:16.3
```

Further documentation is provided for [MySQL](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/resources/db/mysql/petclinic_db_setup_mysql.txt)
and [PostgreSQL](https://github.com/spring-projects/spring-petclinic/blob/main/src/main/resources/db/postgres/petclinic_db_setup_postgres.txt).

Instead of vanilla `docker` you can also use the provided `docker-compose.yml` file to start the database containers. Each one has a profile just like the Spring profile:

```bash
docker-compose --profile mysql up
```

or

```bash
docker-compose --profile postgres up
```

### Navigate to PetClinic

Visit [http://localhost:8080](http://localhost:8080) in your browser to view the PetClinic application.

<img width="1042" alt="petclinic-screenshot" src="https://cloud.githubusercontent.com/assets/838318/19727082/2aee6d6c-9b8e-11e6-81fe-e889a5ddfded.png">    

## Additional Security Integration

In addition to the above mentioned security scans, the associated instance of JFrog Artifactory is also configured with [JFrog X-Ray](https://jfrog.com/help/r/jfrog-security-documentation), which scans the published container image. X-Ray scan results include the following:

- Known vulnerabilities
- Malicious packages
- Detected secrets
- Policy violations             
- SBOM Generation

## License

The Spring PetClinic sample application is released under version 2.0 of the [Apache License](https://www.apache.org/licenses/LICENSE-2.0).
