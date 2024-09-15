# Imagem do runtime ASP.NET
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

# Expor a porta 80
EXPOSE 80

# Copiar os arquivos de build para a imagem final
COPY ./publish ./

# Definir o ponto de entrada da aplicação
ENTRYPOINT ["dotnet", "jellyfin.dll"]
