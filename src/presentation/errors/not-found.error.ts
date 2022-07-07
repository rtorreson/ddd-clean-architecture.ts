import { StatusCodes } from 'http-status-codes';
import emoji from 'node-emoji';

import { ApiError } from './api.error';

class NotFoundError extends ApiError {
  constructor(method: string, path: string) {
    super(
      StatusCodes.NOT_FOUND,
      'not_found',
      `${emoji.get('cry')} Não foi possivel encontrar ${method.toUpperCase()} ${path} neste server.`
    );
  }
}

export { NotFoundError };
