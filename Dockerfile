FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Limpar o diretório /app para evitar conflitos
RUN rm -rf /app/*

# Copiar os arquivos para o diretório /app
COPY ./publish_output ./

# Definir o ponto de entrada
ENTRYPOINT ["dotnet", "jellyfin.dll"]

EXPOSE 80
