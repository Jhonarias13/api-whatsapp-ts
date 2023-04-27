FROM public.ecr.aws/docker/library/node:lts-alpine3.17 as node

WORKDIR /app
# Installs latest Chromium (92) package.
RUN apk add --no-cache \
  chromium \
  nss \
  freetype \
  harfbuzz \
  ca-certificates \
  ttf-freefont \
  nodejs \
  yarn

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
  PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Puppeteer v10.0.0 works with Chromium 92.
COPY . .
RUN npm install puppeteer@10.0.0

# RUN npm install pm2 -g
# ENV PM2_PUBLIC_KEY u0vce4cgsvb7the
# ENV PM2_SECRET_KEY 8o06b5nzh8pws9a

RUN npm install

# transpila a commonjs
RUN npm run build

EXPOSE 80
EXPOSE 443
EXPOSE 3001

CMD ["npm", "start", "--", "--no-sandbox"]

# RUN pm2 link 8o06b5nzh8pws9a u0vce4cgsvb7the omnibot-production
