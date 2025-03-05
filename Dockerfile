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

# Usa una imagen base de Alpine para crear una imagen ligera con Nginx
FROM nginx:alpine

# Copia los archivos construidos de la etapa anterior al directorio de Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copia la configuración de Nginx (opcional)
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expone el puerto 80
EXPOSE 80

# Comando de inicio: Nginx
CMD ["nginx", "-g", "daemon off;"]