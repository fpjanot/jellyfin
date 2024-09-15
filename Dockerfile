FROM node:20-alpine AS build

# Instalar o Git
RUN apk add --no-cache git

# Define o diretório de trabalho
WORKDIR /app

# Clonar o repositório e instalar dependências
RUN git clone https://github.com/jellyfin/jellyfin-web.git . && \
    npm install && \
    npm run build:development

# Usa uma imagem intermediária para compilar o projeto Jellyfin usando os arquivos em ./publish_output
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS publish

# Define o diretório de trabalho para o projeto .NET
WORKDIR /app

# Copia os arquivos publicados do projeto Jellyfin
COPY ./publish_output .

# Usa a imagem final do Nginx para servir o aplicativo web e os arquivos do projeto .NET
FROM nginx:alpine

# Copia os arquivos construídos do web client para o diretório de publicação do Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copia os arquivos do projeto .NET para um diretório dentro do container (ajuste conforme necessário)
COPY --from=publish /app /usr/share/nginx/html/jellyfin-app

# Expor a porta 80 para acessar o serviço
EXPOSE 80

# Inicia o servidor Nginx
CMD ["nginx", "-g", "daemon off;"]
