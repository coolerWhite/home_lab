certbot certonly --manual --preferred-challenges dns --email ronaldinio09@yandex.ru \
  -d "coolwhite.tech" -d "*.coolwhite.tech" \
  --agree-tos --no-eff-email