import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.books, this.onBookTap});
  final List<BookEntity> books;
  final ValueChanged<BookEntity>? onBookTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        final item = books[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BookListViewItem(
            book: item,
            onTap: () {
              onBookTap?.call(item);
              GoRouter.of(context).push(Routes.bookDetailsView, extra: item);
            },
          ),
        );
      },
    );
  }
}
