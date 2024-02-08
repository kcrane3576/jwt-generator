# github-app-jwt-generator
Simple jwt generator
ref: https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app/generating-a-json-web-token-jwt-for-a-github-app

## How To Setup
- create `.env.local` in root of the project and fill in your own information based on the variables in `.env.local`

## How To Use
- Run
```shell
    ENV=local docker-compose down -v && \
    docker system prune -af && \
    docker-compose --env-file .env.local up --build
```