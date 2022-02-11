FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal AS base
WORKDIR /app
EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

# Creates a non-root user with an explicit UID and adds permission to access the /app folder
# For more info, please refer to https://aka.ms/vscode-docker-dotnet-configure-containers
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS build
WORKDIR /src
COPY ["WebApplication-Second-Docker-Test/WebApplication-Second-Docker-Test.csproj", "WebApplication-Second-Docker-Test/"]
RUN dotnet restore "WebApplication-Second-Docker-Test/WebApplication-Second-Docker-Test.csproj"
COPY . .
WORKDIR "/src/WebApplication-Second-Docker-Test"
RUN dotnet build "WebApplication-Second-Docker-Test.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApplication-Second-Docker-Test.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplication-Second-Docker-Test.dll"]
