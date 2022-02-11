#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["WebApplication-Second-Docker-Test.csproj", "/"]
RUN dotnet restore "/WebApplication-Second-Docker-Test.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "WebApplication-Second-Docker-Test.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApplication-Second-Docker-Test.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplication-Second-Docker-Test.dll"]