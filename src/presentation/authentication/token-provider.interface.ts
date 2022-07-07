import { Token } from '@presentation/authentication/token';

export interface ITokenProvider {
  createAccessToken(userId: number | string, username: string, email: string, roles: string[]): Token;
  createRefreshToken(userId: number | string, username: string, email: string): Token;
  validateAccessToken(token: string): boolean;
  validateRefreshToken(token: string): boolean;
  parseToken(token: string): Token | undefined;
  getTokenFromHeader(header: string): string;
}
