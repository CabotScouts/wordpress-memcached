# wordpress-memcached
Extension of the Wordpress docker image to add memcache support.

```
services:

  wordpress:
    container_name: wordpress
    image: https://github.com/CabotScouts/wordpress-memcached:latest
    restart: unless-stopped
    depends_on:
      memcached:
        condition: service_healthy
    volumes:
      - data:/var/www/html
    networks:
      - traefik
      - mariadb
      - bridge
    healthcheck:
      test: ["CMD-SHELL", "ps -ef | grep apache2"]
      start_period: 10s
      interval: 10s
      timeout: 5s
      retries: 3

  memcached:
    container_name: wordpress_memcached
    image: memcached:alpine
    restart: unless-stopped
    networks:
      - bridge
    healthcheck:
      test: echo stats | nc localhost 11211
      interval: 10s
      timeout: 5s
      retries: 3

volumes:
  data:

networks:
  traefik:
    external: true
  mariadb:
    external: true
  bridge:
    driver: bridge
```
