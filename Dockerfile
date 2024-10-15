FROM ghcr.io/cirruslabs/flutter:3.24.3 as builder
WORKDIR /usr/src/app
COPY . .
RUN flutter pub get
RUN flutter build web --release

FROM nginx:1.23.3 as runner
# Copiamos los archivos estaticos al container
COPY --from=builder /usr/src/app/build/web /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
# Tenemos la configuracion de nginx para SPA
COPY docker/nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD [ "nginx","-g", "daemon off;" ]