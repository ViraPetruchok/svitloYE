import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:http/http.dart' as http;

void main() async {
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(_proxyHandler);

  final server = await io.serve(handler, 'localhost', 8080);
  print('Proxy server running on http://${server.address.host}:${server.port}');
}

Future<Response> _proxyHandler(Request request) async {
  final response = Uri.parse('https://corsproxy.io/?url=https://rsshub.app/telegram/channel/Ukrenergo');

  try {
    final upstreamResponse = await http.get(response);

    return Response.ok(
      upstreamResponse.body,
      headers: {
        'Content-Type': 'application/rss+xml; charset=utf-8',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
      },
    );
  } catch (e) {
    return Response.internalServerError(
      body: 'Помилка запиту до RSS: $e',
    );
  }
}
