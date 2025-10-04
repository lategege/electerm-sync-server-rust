# Electerm sync server rust

[![Build Status](https://github.com/electerm/electerm-sync-server-rust/actions/workflows/linux.yml/badge.svg)](https://github.com/electerm/electerm-sync-server-rust/actions)

A simple rust electerm data sync server.

## Use


```bash
git clone git@github.com:electerm/electerm-sync-server-rust.git
cd electerm-sync-server-rust

# create env file, then edit .env
cp sample.env .env

cargo run

# would show something like
# server running at http://127.0.0.1:7837

# in electerm sync settings, set custom sync server with:
# server url: http://127.0.0.1:7837
# Then you can use http://127.0.0.1:7837/api/sync as API Url in electerm custom sync


# JWT_SECRET: your JWT_SECRET in .env
# JWT_USER_NAME: one JWT_USER in .env
```

## Docker build
```bash
git clone https://github.com/lategege/electerm-sync-server-rust.git
cd electerm-sync-server-rust

#Docker build
docker build electerm-sync-server-rust:latest .
```


## Docker run with compose.yaml
```bash
version: '3.8'
services:
  electerm-rust:
    image: electerm-sync-server-rust:latest
    container_name: electerm-rust
    ports:
      - "7837:7837"
    environment:
      - JWT_SECRET=YOUR OWN SECERT
      - JWT_USERS=user1,user2
      - PORT=7837
      - HOST=0.0.0.0
    volumes:
      - ./data:/app/data
    restart: always
```

## Test

```sh
cargo test -- --test-threads=1
```

## Write your own data store

Just take [src/file-store.rs](src/file-store.rs) as an example, write your own read/write method

## Sync server in other languages

[https://github.com/electerm/electerm/wiki/Custom-sync-server](https://github.com/electerm/electerm/wiki/Custom-sync-server)

## License

MIT
