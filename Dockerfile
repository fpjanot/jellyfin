FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Copiar os arquivos para o diretório /app
COPY ./publish_output ./

# Definir o ponto de entrada
ENTRYPOINT ["dotnet", "Jellyfin.Server.Implementations.dll"]

EXPOSE 80