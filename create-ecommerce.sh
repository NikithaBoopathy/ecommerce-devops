#!/bin/bash

set -e

BASE_PACKAGE="com.example"

create_service() {
  SERVICE_NAME=$1
  PORT=$2
  ENTITY_NAME=$3

  echo "Creating $SERVICE_NAME..."

  PACKAGE_NAME="$BASE_PACKAGE.${SERVICE_NAME//-/.}"
  PACKAGE_PATH="src/main/java/com/example/${SERVICE_NAME//-//}"

  mkdir -p $SERVICE_NAME
  cd $SERVICE_NAME

  mkdir -p $PACKAGE_PATH/{controller,service,repository,entity}
  mkdir -p src/main/resources

  CLASS_NAME=$(echo $SERVICE_NAME | sed 's/-//g' | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

# ---------------- POM ----------------
cat > pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0">
<modelVersion>4.0.0</modelVersion>

<groupId>com.example</groupId>
<artifactId>$SERVICE_NAME</artifactId>

<parent>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-parent</artifactId>
<version>3.3.0</version>
</parent>

<properties>
<java.version>17</java.version>
</properties>

<dependencies>
<dependency>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-web</artifactId>
</dependency>

<dependency>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>

<dependency>
<groupId>org.postgresql</groupId>
<artifactId>postgresql</artifactId>
</dependency>

<dependency>
<groupId>org.projectlombok</groupId>
<artifactId>lombok</artifactId>
<optional>true</optional>
</dependency>

<dependency>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-starter-actuator</artifactId>
</dependency>
</dependencies>

<build>
<plugins>
<plugin>
<groupId>org.springframework.boot</groupId>
<artifactId>spring-boot-maven-plugin</artifactId>
</plugin>
</plugins>
</build>
</project>
EOF

# ---------------- MAIN ----------------
cat > $PACKAGE_PATH/${CLASS_NAME}Application.java <<EOF
package $PACKAGE_NAME;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ${CLASS_NAME}Application {
  public static void main(String[] args) {
    SpringApplication.run(${CLASS_NAME}Application.class, args);
  }
}
EOF

# ---------------- ENTITY ----------------
cat > $PACKAGE_PATH/entity/${ENTITY_NAME}.java <<EOF
package $PACKAGE_NAME.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ${ENTITY_NAME} {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  private String name;
}
EOF

# ---------------- REPO ----------------
cat > $PACKAGE_PATH/repository/${ENTITY_NAME}Repository.java <<EOF
package $PACKAGE_NAME.repository;

import $PACKAGE_NAME.entity.${ENTITY_NAME};
import org.springframework.data.jpa.repository.JpaRepository;

public interface ${ENTITY_NAME}Repository extends JpaRepository<${ENTITY_NAME}, Long> {
}
EOF

# ---------------- SERVICE ----------------
cat > $PACKAGE_PATH/service/${ENTITY_NAME}Service.java <<EOF
package $PACKAGE_NAME.service;

import $PACKAGE_NAME.entity.${ENTITY_NAME};
import $PACKAGE_NAME.repository.${ENTITY_NAME}Repository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ${ENTITY_NAME}Service {

  private final ${ENTITY_NAME}Repository repo;

  public ${ENTITY_NAME} create(${ENTITY_NAME} obj) {
    return repo.save(obj);
  }

  public List<${ENTITY_NAME}> getAll() {
    return repo.findAll();
  }
}
EOF

# ---------------- CONTROLLER ----------------
cat > $PACKAGE_PATH/controller/${ENTITY_NAME}Controller.java <<EOF
package $PACKAGE_NAME.controller;

import $PACKAGE_NAME.entity.${ENTITY_NAME};
import $PACKAGE_NAME.service.${ENTITY_NAME}Service;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/${ENTITY_NAME,,}s")
@RequiredArgsConstructor
public class ${ENTITY_NAME}Controller {

  private final ${ENTITY_NAME}Service service;

  @PostMapping
  public ${ENTITY_NAME} create(@RequestBody ${ENTITY_NAME} obj) {
    return service.create(obj);
  }

  @GetMapping
  public List<${ENTITY_NAME}> getAll() {
    return service.getAll();
  }
}
EOF

# ---------------- CONFIG ----------------
cat > src/main/resources/application.yml <<EOF
server:
  port: $PORT

spring:
  datasource:
    url: jdbc:postgresql://\${DB_HOST:localhost}:5432/${SERVICE_NAME}
    username: \${DB_USERNAME:postgres}
    password: \${DB_PASSWORD:postgres}

  jpa:
    hibernate:
      ddl-auto: update
EOF

cd ..
}

# =============================
# CREATE ALL SERVICES
# =============================

create_service user-service 8081 User
create_service product-service 8082 Product
create_service order-service 8083 Order
create_service payment-service 8084 Payment

echo "✅ All microservices created!"
