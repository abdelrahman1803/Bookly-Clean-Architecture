import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/core/utilities/widgets/custom_error_image_widget.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeaturedBooksListView extends StatelessWidget {
  const FeaturedBooksListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.separated(
        itemCount: books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final imageUrl = books[index].image ?? '';
          return GestureDetector(
            onTap: () => GoRouter.of(context).push(Routes.bookDetailsView),
            child: books.isNotEmpty
                ? CustomBookItem(imageUrl: imageUrl)
                : const ErrorImageWidget(),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
