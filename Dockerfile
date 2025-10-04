# ---- Build Stage ----
FROM docker.m.daocloud.io/library/rust:1.90 AS builder

WORKDIR /app

RUN apt-get update && apt-get install -y pkg-config libssl-dev && rm -rf /var/lib/apt/lists/*

# 拉取源码
RUN git clone https://github.com/electerm/electerm-sync-server-rust.git

WORKDIR /app/electerm-sync-server-rust

# 构建 release
RUN cargo build --release

RUN ls -lh /app/electerm-sync-server-rust/target/release/

# ---- Runtime Stage ----
FROM docker.m.daocloud.io/library/debian:bookworm-slim

LABEL maintainer="lategege <x385271984@gmail.com>" \
      version="1.0.0" \
      description="Electerm sync server Rust version" \
      url="https://github.com/electerm/electerm-sync-server-rust"


RUN apt-get update && apt-get install -y libssl3 ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 拷贝二进制
COPY --from=builder /app/electerm-sync-server-rust/target/release/electerm-sync-rust-server /usr/local/bin/electerm-sync-rust-server

# 默认端口
EXPOSE 7837

# 环境变量（用户可以覆盖）
ENV JWT_SECRET=changeme \
    PORT=7837 \
    HOST=0.0.0.0\
    JWT_USERS=user1,user2 \
    FILE_STORE_PATH=/app/data

# 数据存储目录
RUN mkdir -p /app/data

VOLUME ["/app/data"]

# 启动
CMD ["electerm-sync-rust-server"]
