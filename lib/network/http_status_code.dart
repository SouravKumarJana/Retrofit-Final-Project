enum HttpStatusCode {
  ok(200),
  created(201),
  accepted(202),
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  internalServerError(500),
  badGateway(502),
  serviceUnavailable(503),
  gatewayTimeout(504);

  final int code;
  const HttpStatusCode(this.code);

  static HttpStatusCode from(int? code) {
    return HttpStatusCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => internalServerError,
    );
  }
}
