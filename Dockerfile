# first-stage Base Image ly heyye l SDK

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# bya3mal set lal workdirectory metel add , copy , cmd , entrypoint
WORKDIR /source

# bero7 bya3mal copy la kel files l csproject
COPY *.csproj .

#bero7 bejeb kel l dependencies ly baddo yeha l project
RUN dotnet restore

#copy and publish all application files
COPY . .

# hon aam ba3mal publish la2eno ana khales l mashro3 w bema enno l docker lezem ykono l filet fe msh kteer fa l 
# release bta3ml remove lal debugging files amma eza ba3dne aam beshte8el bl mashrooo3 b7ot debug instead of release
RUN dotnet publish -c release -o /app 

#final-satge image ly heyye runtime
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app .
#l entrypoint howe l mas2ool aan lashu baddo yaamal run
#yaany hayde badda t7added shu ly baddo yaamal run jowa l container
ENTRYPOINT [ "dotnet" , "hrapp.dll" ]