FROM maven:3-eclipse-temurin-11@sha256:e01fae5dea5352a794a106263ca5355f40e694fe872212a6ead1c2dc2ce2ca28 as builder

WORKDIR /build
COPY . .
RUN mvn clean verify

FROM eclipse-temurin:11-jre@sha256:8f0a99f12dfc7ff2524f1550ffd6ab432597cd20417413b46cb96c7b9ec2b7f0

# renovate: datasource=github-releases depName=apangin/jattach
ENV JATTACH_VERSION=1.5

RUN curl -Lo /usr/local/bin/jattach https://github.com/apangin/jattach/releases/download/v${JATTACH_VERSION}/jattach \
 && chmod +x /usr/local/bin/jattach

COPY --from=builder /build/target/demo.jar /demo.jar

ENTRYPOINT ["java", "-jar", "/demo.jar"]
