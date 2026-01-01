import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView(this.books, {super.key});
  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.separated(
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => GoRouter.of(
              context,
            ).push(Routes.bookDetailsView, extra: books[index]),
            child: CustomBookItem(imageUrl: books[index].image!),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 6),
      ),
    );
  }
}
