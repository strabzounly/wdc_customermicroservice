# Use the official .NET Core 8.* SDK as a build image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /src

# Copy project files and restore dependencies
COPY . ./
RUN dotnet restore

# Copy the rest of the project files and build the project
COPY . ./
RUN dotnet publish -c Release -o out

# Use the official .NET Core 8.* runtime image as the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy the build outputs from the build image
COPY --from=build-env /app/out .

# Expose the port the app listens on
#EXPOSE 5151

# Define the entry point for the container
ENTRYPOINT ["dotnet", "CustomerMicroservice.dll"]