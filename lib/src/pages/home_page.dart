import 'package:flutter/material.dart';
import 'package:flutter_beever_kanye_west_app/src/hooks/quote_hook.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hooks/favorites_hook.dart';
import 'my_quotes_page.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(context) {
    final quote = useQuote();
    final favorites = useFavorites();
    final favoriteQuotes = favorites.getAll();
    final isQuoteFavorited = favorites.isQuoteFavorited(quote.data);
    final isLoading = quote.isFetching || favorites.isFetching;

    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: kToolbarHeight),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListTile(
              leading: ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const MyQuotesPage();
                          }),
                        );
                      },
                icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  child: SizedBox.square(
                    dimension: 24.0,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.edit_note_outlined),
                  ),
                ),
                label: const Text("MY QUOTES"),
              ),
              trailing: ElevatedButton.icon(
                onPressed: isLoading ? null : quote.refetch,
                icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  child: SizedBox.square(
                    dimension: 24.0,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.format_quote_outlined),
                  ),
                ),
                label: const Text("GET QUOTE"),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(kToolbarHeight / 2.0),
                color: Colors.yellow[500],
                width: double.maxFinite,
                child: SelectableText(
                  quote.data?.quote ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.merge(
                        const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListTile(
              trailing: ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () {
                        if (quote.hasData == false) {
                          return;
                        }

                        favorites.post(quote.requiredData);
                      },
                icon: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Theme.of(context).colorScheme.secondary,
                  child: SizedBox.square(
                    dimension: 24.0,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Icon(isQuoteFavorited
                            ? Icons.favorite
                            : Icons.favorite_outline),
                  ),
                ),
                label: const Text("ADD TO FAVORITES"),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Divider(height: 1.0, thickness: 1.0),
                ListTile(
                  title: const Text('Favorites'),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(Icons.favorite_outline),
                  ),
                  trailing: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    child: isLoading
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(),
                          )
                        : Text(favoriteQuotes.length.toString()),
                  ),
                ),
                const Divider(height: 1.0, thickness: 1.0),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              favorites.refresh();
                            },
                            child: ListView.separated(
                              key: ValueKey(favoriteQuotes.length),
                              padding: const EdgeInsets.only(
                                top: kToolbarHeight / 3.0,
                                bottom: kToolbarHeight,
                              ),
                              itemCount: favoriteQuotes.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: kToolbarHeight / 4.0,
                                );
                              },
                              itemBuilder: (context, index) {
                                index = favoriteQuotes.length - index - 1;
                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        favoriteQuotes[index].quote ?? '',
                                      ),
                                      const SizedBox(
                                        height: kToolbarHeight / 4.0,
                                      ),
                                      const Divider(
                                        height: 1,
                                        thickness: 1,
                                        endIndent: kToolbarHeight / 2.0,
                                      ),
                                    ],
                                  ),
                                  leading: IconButton(
                                    onPressed: () {
                                      favorites.delete(index);
                                    },
                                    icon: const Icon(Icons.close_outlined),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
