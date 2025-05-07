class RequestData {
  final dynamic data;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;

  RequestData({
    required this.data,
    required this.headers,
    required this.params,
  });
}