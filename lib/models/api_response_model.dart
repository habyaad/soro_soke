class ApiResponse{
  final bool success;
  final String message;
  final Object? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });
}