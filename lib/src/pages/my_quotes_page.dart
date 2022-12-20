import 'package:flutter/material.dart';
import 'package:flutter_beever_kanye_west_app/src/hooks/my_quotes_hook.dart';
import 'package:flutter_beever_kanye_west_app/src/types/quote/quote_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyQuotesPage extends HookWidget {
  const MyQuotesPage({super.key});

  @override
  Widget build(context) {
    final myQuotes = useMyQuotes();
    final myQuoteList = myQuotes.getAll();
    final isLoading = myQuotes.isFetching;
    final textEditingController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quotes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Start writing your quote here',
                suffix: IconButton(
                  onPressed: textEditingController.clear,
                  icon: const Icon(Icons.close_outlined),
                ),
              ),
              maxLength: null,
              maxLines: null,
              minLines: null,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      myQuotes.post(QuoteModel(
                        quote: textEditingController.text,
                      ));
                    },
              child: Row(
                children: const [
                  Expanded(
                    child: Center(
                      child: Text('SAVE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Saved'),
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.save_outlined),
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              child: isLoading
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(),
                    )
                  : Text(myQuoteList.length.toString()),
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
                        myQuotes.refresh();
                      },
                      child: ListView.separated(
                        key: ValueKey(myQuoteList.length),
                        padding: const EdgeInsets.only(
                          top: kToolbarHeight / 3.0,
                          bottom: kToolbarHeight,
                        ),
                        itemCount: myQuoteList.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: kToolbarHeight / 4.0,
                          );
                        },
                        itemBuilder: (context, index) {
                          index = myQuoteList.length - index - 1;
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  myQuoteList[index].quote ?? '',
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
                                myQuotes.delete(index);
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
    );
  }
}
