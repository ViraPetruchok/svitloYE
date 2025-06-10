import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:http/http.dart' as http;

void main() async {
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_proxyHandler);

  final server = await io.serve(handler, 'localhost', 8080);
  print('Proxy server running on http://${server.address.host}:${server.port}');
}

Future<Response> _proxyHandler(Request request) async {
  final targetUrl = Uri.parse('https://rsshub.app/telegram/channel/lvivoblenergo');

  final upstreamResponse = await http.get(targetUrl);

  return Response.ok(
    upstreamResponse.body,
    headers: {'Content-Type': 'application/rss+xml'},
  );
}
