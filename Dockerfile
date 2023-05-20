# Dockerfile

# Frontend - React.js
FROM node:14.16.1 AS frontend
WORKDIR /app
COPY frontend/package.json frontend/yarn.lock ./
RUN yarn install
COPY frontend ./
RUN yarn build

# Backend - Node.js
FROM node:14.16.1 AS backend
WORKDIR /app
COPY backend/package.json backend/yarn.lock ./
RUN yarn install
COPY backend ./

# Combine frontend and backend
FROM node:14.16.1
WORKDIR /app
COPY --from=frontend /app/build ./frontend
COPY --from=backend /app ./

EXPOSE 3000
CMD ["node", "server/index.js"]  # Đường dẫn đã được thay đổi tại đây
