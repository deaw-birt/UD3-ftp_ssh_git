# DEAW03 TareaEvaluativa2 - Alternativas de acceso a un servidor Apache

Repositorio base para la práctica de Docker.

## Construcción de la imagen

docker build -t deaw03 .

## Ejecución del contenedor

docker run -p 80:80 -p 443:443 deaw03
