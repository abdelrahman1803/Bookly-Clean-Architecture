import 'package:bookly/core/shimmer/placeholders/vertical_book_list_item_shimmer.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';

class LatestBooksListView extends StatelessWidget {
  const LatestBooksListView({
    super.key,
    required this.books,
    this.isLoadingMore = false,
  });

  final List<BookEntity> books;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: isLoadingMore ? books.length + 1 : books.length,
      itemBuilder: (BuildContext context, int index) {
        if (isLoadingMore && index == books.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: VerticalBookListItemShimmer(),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: BookListViewItem(book: books[index]),
        );
      },
    );
  }
}
