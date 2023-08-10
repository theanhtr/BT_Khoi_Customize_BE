#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["MISA.WebFresher052023.CTM/MISA.WebFresher052023.CTM.csproj", "MISA.WebFresher052023.CTM/"]
COPY ["MISA.WebFresher052023.CTM.Application/MISA.WebFresher052023.CTM.Application.csproj", "MISA.WebFresher052023.CTM.Application/"]
COPY ["MISA.WebFresher052023.CTM.Domain/MISA.WebFresher052023.CTM.Domain.csproj", "MISA.WebFresher052023.CTM.Domain/"]
COPY ["MISA.WebFresher052023.CTM.Infrastructure/MISA.WebFresher052023.CTM.Infrastructure.csproj", "MISA.WebFresher052023.CTM.Infrastructure/"]
RUN dotnet restore "MISA.WebFresher052023.CTM/MISA.WebFresher052023.CTM.csproj"
COPY . .
WORKDIR "/src/MISA.WebFresher052023.CTM"
RUN dotnet build "MISA.WebFresher052023.CTM.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "MISA.WebFresher052023.CTM.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MISA.WebFresher052023.CTM.dll"]