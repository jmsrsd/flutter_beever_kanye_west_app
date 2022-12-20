import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

QueryHook<T> useQuery<T>(List keys, Future<T> Function() fetch) {
  final refetching = useState(0);

  final fetching = useFuture(
    useMemoized(fetch, [...keys, refetching.value]),
  );

  return QueryHook(
    refetching: refetching,
    fetching: fetching,
  );
}

class QueryHook<T> {
  late final ValueNotifier<int> _refetching;
  late final AsyncSnapshot<T> _fetching;

  QueryHook({
    required ValueNotifier<int> refetching,
    required AsyncSnapshot<T> fetching,
  }) {
    _refetching = refetching;
    _fetching = fetching;
  }

  bool get isFetching {
    return _fetching.connectionState != ConnectionState.done;
  }

  bool get hasData {
    return _fetching.hasData;
  }

  T? get data {
    return _fetching.data;
  }

  T get requiredData {
    return _fetching.requireData;
  }

  bool get hasError {
    return _fetching.hasError;
  }

  Object? get error {
    return _fetching.error;
  }

  void refetch() {
    _refetching.value += 1;
  }
}
