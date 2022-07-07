import { HealthStatusResponse } from '@application/health/health-status.response';
import { HealthStatus } from '@domain/health/health-status';

describe('Testing HealthStatusResponse generation', () => {
  it('should return a valid HealthStatusResponse from domain model', () => {
    return expect(HealthStatusResponse.fromDomainModel(new HealthStatus('Ok', 'Ao infinito e além'))).toEqual(
      new HealthStatusResponse('Ok', 'Ao infinito e além')
    );
  });
});
