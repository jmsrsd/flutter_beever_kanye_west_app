import 'package:flutter_beever_kanye_west_app/src/api/quote_api.dart';
import 'package:flutter_beever_kanye_west_app/src/hooks/query_hook.dart';

import '../types/quote/quote_model.dart';
import '../utils/network_fetcher.dart';

QueryHook<QuoteModel> useQuote() {
  return useQuery([quoteApiRoute], () async {
    final fetcher = NetworkFetcher();

    final quote = QuoteModel.fromMap(
      await fetchQuote(fetcher: fetcher),
    );

    fetcher.close();

    return quote;
  });
}
