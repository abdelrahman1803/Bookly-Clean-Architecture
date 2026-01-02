import 'package:bookly/constants.dart';
import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class BookmarksView extends StatelessWidget {
  const BookmarksView({super.key});

  String _bookmarkKey(BookEntity book) {
    final id = book.bookId;
    if (id.isNotEmpty) {
      return id;
    }
    return book.title;
  }

  @override
  Widget build(BuildContext context) {
    final error = Theme.of(context).colorScheme.error;
    final saturatedError = HSLColor.fromColor(
      error,
    ).withSaturation(1).withLightness(0.45).toColor();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                  const SizedBox(width: 8),
                  const Text('Bookmarks', style: Styles.textStyle20),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ValueListenableBuilder<Box<BookEntity>>(
                  valueListenable: Hive.box<BookEntity>(
                    kBookmarksBox,
                  ).listenable(),
                  builder: (context, box, _) {
                    final keys = box.keys
                        .cast<String>()
                        .toList()
                        .reversed
                        .toList();
                    final books = keys
                        .map((key) => box.get(key))
                        .whereType<BookEntity>()
                        .toList();
                    if (books.isEmpty) {
                      return const Center(
                        child: Text(
                          'No bookmarks yet',
                          style: Styles.textStyle16,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        final key = _bookmarkKey(book);

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Slidable(
                            key: ValueKey(key),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                CustomSlidableAction(
                                  onPressed: (_) async {
                                    await box.delete(key);
                                  },
                                  backgroundColor: saturatedError,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.trash,
                                        size: 32,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Remove',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: BookListViewItem(book: book),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
