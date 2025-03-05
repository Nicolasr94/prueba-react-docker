# Usa una imagen base de Node.js para construir el proyecto
FROM node:18-alpine AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia los archivos package*.json y package-lock.json (si existe)
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos de la aplicación
COPY . .

# Construye la aplicación React
RUN npm run build

# Usa una imagen base de Alpine para crear una imagen ligera
FROM alpine:latest

# Copia los archivos construidos de la etapa anterior
COPY --from=build /app/dist /usr/share/nginx/html

# Expone el puerto 80 (opcional, pero buena práctica)
EXPOSE 80
CMD ["npm", "start"]
# Comando de inicio (no necesario, ya que Nginx en el host servirá los archivos)