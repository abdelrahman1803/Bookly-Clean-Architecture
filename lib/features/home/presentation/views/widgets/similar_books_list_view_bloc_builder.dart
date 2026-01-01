import 'package:bookly/core/shimmer/placeholders/book_cover_shimmer.dart';
import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/core/utilities/widgets/custom_error_widget.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/similar_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarBooksListViewBlocBuilder extends StatelessWidget {
  const SimilarBooksListViewBlocBuilder({super.key, required this.book});
  final BookEntity book;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksState>(
      builder: (context, state) {
        if (state is SimilarBooksSuccess) {
          if (state.book.isEmpty) {
            return const Center(
              child: Text('No similar books found', style: Styles.textStyle16),
            );
          }
          return SimilarBooksListView(state.book);
        } else if (state is SimilarBooksFailure) {
          return CustomErrorWidget(
            errMessage: state.message,
            onRetry: () => context.read<SimilarBooksCubit>().fetchSimilarBooks(
              book.category,
            ),
          );
        }
        return ListView.separated(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              const BookCoverShimmer(),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        );
      },
    );
  }
}
