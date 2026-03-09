# Utilizamos una imagen oficial de Ubuntu
FROM ubuntu:22.04

# Damos información sobre la imagen que estamos creando
LABEL \
    version="1.0" \
    description="Ubuntu + Apache2 + virtual host" \
    maintainer="usuarioBIRT <usuarioBIRT@birt.eus>"

# Actualizamos la lista de paquetes e instalamos nano y apache2
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nano apache2 && \
    rm -rf /var/lib/apt/lists/*

# Creamos directorios para los sitios web y configuraciones
RUN mkdir -p /var/www/html/sitio1 /var/www/html/sitio2

# Copiamos archivos al contenedor
COPY index1.html /var/www/html/sitio1/index.html
COPY index2.html /var/www/html/sitio2/index.html
COPY sitio1.conf /etc/apache2/sites-available/
COPY sitio2.conf /etc/apache2/sites-available/
COPY sitio1.key /etc/ssl/private/
COPY sitio1.cer /etc/ssl/certs/

# Habilitamos los sitios y el módulo SSL
RUN a2ensite sitio1.conf && \
    a2ensite sitio2.conf && \
    a2enmod ssl

# Exponemos los puertos
EXPOSE 80
EXPOSE 443

# Comando por defecto al iniciar el contenedor
CMD ["apachectl", "-D", "FOREGROUND"]
