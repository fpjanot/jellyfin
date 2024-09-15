FROM node:20-alpine AS build

# Define o diretório de trabalho
WORKDIR /app

# Clona o repositório e instala dependências
RUN git clone https://github.com/jellyfin/jellyfin-web.git . && \
    npm install && \
    npm run build:development

# Usa uma imagem mais leve para servir o aplicativo
FROM nginx:alpine

# Copia os arquivos construídos para o diretório de publicação
COPY --from=build /app/dist /usr/share/nginx/html

# Expor a porta 80 para acessar o serviço
EXPOSE 80

# Inicia o servidor Nginx
CMD ["nginx", "-g", "daemon off;"]
