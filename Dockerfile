# Use the official .NET SDK (version 8) as the build image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory
WORKDIR /src

# Copy the csproj and restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the remaining files to the working directory
COPY . .

# Build the application
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime (version 8) as the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0

# Set the working directory
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/publish .

# Expose port 5151 for the application
EXPOSE 5151

# Set the entry point for the application
ENTRYPOINT ["dotnet", "CustomerMicroservice.dll"]