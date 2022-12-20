import 'package:dio/dio.dart';

import '../utils/network_fetcher.dart';

const quoteApiRoute = 'https://api.kanye.rest/';

Future<Map<String, dynamic>> fetchQuote({
  required NetworkFetcher fetcher,
}) async {
  final fetchOptions = Options(
    responseType: ResponseType.json,
  );

  final response = await fetcher.get(
    quoteApiRoute,
    options: fetchOptions,
  );

  return response.data;
}
