import 'package:bookly/core/shimmer/placeholders/vertical_book_list_item_shimmer.dart';
import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/core/utilities/widgets/custom_error_widget.dart';
import 'package:bookly/features/search/UI/manager/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/UI/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultListViewBlocBuilder extends StatelessWidget {
  const SearchResultListViewBlocBuilder({super.key});

  Widget _buildLoadingList() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) => const VerticalBookListItemShimmer(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBooksCubit, SearchBooksState>(
      builder: (context, state) {
        if (state is SearchBooksSuccess) {
          if (state.books.isEmpty) {
            return const Center(
              child: Text('No books found', style: Styles.textStyle16),
            );
          }
          return SearchResultListView(
            books: state.books,
            onBookTap: (book) {
              context.read<SearchBooksCubit>().saveBookToHistory(book);
            },
          );
        } else if (state is SearchBooksHistorySuccess) {
          if (state.bookHistory.isEmpty) {
            return const Center(
              child: Text('No search history yet', style: Styles.textStyle16),
            );
          }
          return SearchResultListView(
            books: state.bookHistory,
            onBookTap: (book) {
              context.read<SearchBooksCubit>().saveBookToHistory(book);
            },
          );
        } else if (state is SearchBooksFailure) {
          return CustomErrorWidget(errMessage: state.message);
        } else if (state is SearchBooksLoading) {
          return _buildLoadingList();
        } else if (state is SearchBooksHistoryLoading) {
          return _buildLoadingList();
        } else {
          return const Center(
            child: Text('Write a book name', style: Styles.textStyle16),
          );
        }
      },
    );
  }
}
