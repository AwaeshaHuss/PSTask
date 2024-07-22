import 'dart:convert';
import 'package:http/http.dart' show Response, get, post, put, patch, delete;

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class HttpService {
  final String baseUrl;

  HttpService(this.baseUrl);

  Future<Response> request<T>(
    String endpoint, {
    required HttpMethod method,
    Map<String, String>? headers,
    T? body,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final jsonBody = body != null ? jsonEncode(body) : null;

    switch (method) {
      case HttpMethod.GET:
        return await get(url, headers: headers);
      case HttpMethod.POST:
        return await post(url, headers: headers, body: jsonBody);
      case HttpMethod.PUT:
        return await put(url, headers: headers, body: jsonBody);
      case HttpMethod.PATCH:
        return await patch(url, headers: headers, body: jsonBody);
      case HttpMethod.DELETE:
        return await delete(url, headers: headers, body: jsonBody);
      default:
        throw UnimplementedError('HTTP method not supported');
    }
  }
}
