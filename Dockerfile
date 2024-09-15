# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copiar os arquivos do projeto e do web client
COPY . .
COPY ./jellyfin-web-dist ./jellyfin-web

# Restaurar e construir a aplicação
RUN dotnet restore
RUN dotnet publish -c Release -o ./publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copiar os arquivos publicados e o web client
COPY --from=build /app/publish .
COPY --from=build /app/jellyfin-web ./jellyfin-web

# Comando para iniciar a aplicação
CMD ["dotnet", "Jellyfin.Server.dll", "--webdir", "/app/jellyfin-web"]
