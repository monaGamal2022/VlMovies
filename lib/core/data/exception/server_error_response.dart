class ServerErrorResponse {
  final int errorStatusCode;
  final String errorMessage;

  ServerErrorResponse({
    required this.errorStatusCode,
    required this.errorMessage,
  });
}
