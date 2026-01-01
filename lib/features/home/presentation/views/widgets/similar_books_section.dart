import 'package:bookly/constants.dart';
import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/similar_books_list_view_bloc_builder.dart';
import 'package:flutter/material.dart';

class SimilarBooksSection extends StatelessWidget {
  const SimilarBooksSection({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: kPaddingSH16,
          child: Text(
            "You may also like",
            style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        const SizedBox(height: 16),
        SimilarBooksListViewBlocBuilder(book: book),
      ],
    );
  }
}
