FROM ghcr.io/cirruslabs/flutter:3.27.0 as builder
WORKDIR /app
COPY . .
RUN flutter pub get && dart run build_runner build -d
RUN flutter build web --release

FROM nginx:alpine3.18-slim as runner
# Copiamos los archivos estaticos al container
COPY --from=builder /app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
# Tenemos la configuracion de nginx para SPA
COPY docker/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD [ "nginx","-g", "daemon off;" ]