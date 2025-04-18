FROM maven:3.8.4-openjdk-17-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean install

FROM maven:3.8.4-openjdk-17-slim
WORKDIR /app
COPY --from=builder /root/.m2 /root/.m2
COPY . .

CMD ["mvn", "test"]
