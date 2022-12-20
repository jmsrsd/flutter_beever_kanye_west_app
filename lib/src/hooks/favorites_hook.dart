import 'package:flutter_beever_kanye_west_app/src/hooks/query_hook.dart';
import 'package:flutter_beever_kanye_west_app/src/types/quote/quote_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/storage_fetcher.dart';

const favoritesStorageKey = 'favorites';

Favorites useFavorites() {
  return Favorites(
    fetcher: useQuery([favoritesStorageKey], () async {
      return await Hive.openBox<String>(favoritesStorageKey);
    }),
  );
}

class Favorites {
  late final QueryHook<StorageFetcher> _fetcher;

  Favorites({
    required QueryHook<StorageFetcher> fetcher,
  }) {
    _fetcher = fetcher;
  }

  void refresh() async {
    await _fetcher.data?.close();
    _fetcher.refetch();
  }

  bool get isFetching {
    return _fetcher.isFetching;
  }

  bool isQuoteFavorited(QuoteModel? quote) {
    return getAll()
        .map((e) => e.quote)
        .where((e) => e != null)
        .contains(quote?.quote);
  }

  List<QuoteModel> getAll() {
    if (_fetcher.data?.isOpen == false) {
      return [];
    }
    return List<String>.of(_fetcher.data?.values ?? [])
        .map(QuoteModel.fromJson)
        .toList();
  }

  void post(QuoteModel quote) async {
    if (quote.quote?.isEmpty == true) {
      return;
    }

    while (_fetcher.isFetching) {
      await Future.delayed(Duration.zero);
    }

    if (isQuoteFavorited(quote)) {
      return;
    }

    await _fetcher.data?.add(quote.toJson());
    refresh();
  }

  void delete(int index) async {
    while (_fetcher.isFetching) {
      await Future.delayed(Duration.zero);
    }
    await _fetcher.data?.deleteAt(index);
    refresh();
  }
}
