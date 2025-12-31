import 'package:bookly/core/shimmer/placeholders/vertical_book_list_item_shimmer.dart';
import 'package:bookly/core/utilities/widgets/custom_error_widget.dart';
import 'package:bookly/features/home/presentation/manager/latest_books_cubit/latest_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/latest_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestBooksBlocBuilder extends StatelessWidget {
  const LatestBooksBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LatestBooksCubit, LatestBooksState>(
      builder: (context, state) {
        if (state is LatestBooksSuccess) {
          return LatestBooksListView(
            books: state.books,
            isLoadingMore: state.isLoadingMore,
          );
        } else if (state is LatestBooksFailure) {
          return CustomErrorWidget(
            errMessage: state.message,
            onRetry: () => context.read<LatestBooksCubit>().fetchLatestBooks(),
          );
        }
        return ListView.separated(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) =>
              const VerticalBookListItemShimmer(),
          separatorBuilder: (context, index) => const SizedBox(width: 10),
        );
      },
    );
  }
}
