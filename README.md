# Pixelpact Playwright Template

This project acts as a template and example of using [Pixelpact](https://github.com/ergon/pixelpact/) and [Playwright](https://playwright.dev/) to visually test a website.

## Requirements

* [Docker and Docker Compose](https://www.docker.com/)
* [Git LFS](https://git-lfs.com/)

## Getting started

1. Start the Pixelpact service

```shell
docker compose up -d
```

2. [Install browsers](https://playwright.dev/docs/browsers)

```shell
npx playwright install chrome
```

3. Run the test

```shell
npm run test
```

## Update Reference Screenshots

```shell
npm run update-screenshots
```