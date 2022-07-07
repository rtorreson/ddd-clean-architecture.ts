import { sync as readPackageJsonSync } from 'read-pkg';

import { getEnvironmentNumber, getEnvironmentString } from '@infrastructure/shared/config/environment';

const AppInfo = {
  APP_VERSION: getEnvironmentString('APP_VERSION', readPackageJsonSync().version),
  APP_NAME: getEnvironmentString('APP_NAME', 'base-app'),
  APP_DESCRIPTION: getEnvironmentString('APP_DESCRIPTION', 'PDI your/dev'),
  AUTHOR_NAME: getEnvironmentString('AUTHOR_NAME', 'Rafael Torreson'),
  AUTHOR_EMAIL: getEnvironmentString('AUTHOR_EMAIL', 'rafael.torreson@hotmail.com')
};

const AppConfig = {
  PORT: getEnvironmentNumber('PORT', 3000),
  BASE_PATH: getEnvironmentString('BASE_PATH', '/api'),
  JWT_SECRET: getEnvironmentString('JWT_SECRET', 'jwtpdidddyd1234'),
  JWT_EXPIRATION: getEnvironmentNumber('JWT_EXPIRATION', 1),
  JWT_REFRESH_EXPIRATION: getEnvironmentNumber('JWT_REFRESH_EXPIRATION', 6)
};

export { AppConfig, AppInfo };
