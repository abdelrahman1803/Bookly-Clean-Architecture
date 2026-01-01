import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/books_details_section.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_deatails_app_bar.dart';
import 'package:bookly/features/home/presentation/views/widgets/similar_books_section.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CustomBookDetailsAppBar(),
              BookDetailsSection(book: book),
              const SizedBox(height: 16),
              SimilarBooksSection(book: book),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
