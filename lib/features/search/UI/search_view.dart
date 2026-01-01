import 'package:bookly/core/utilities/services%20locator/dependency_injection.dart';
import 'package:bookly/features/search/UI/manager/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/UI/views/widgets/search_view_body.dart';
import 'package:bookly/features/search/data/repos/search_repo_impl.dart';
import 'package:bookly/features/search/domain/use%20cases/clear_search_history_use_case.dart';
import 'package:bookly/features/search/domain/use%20cases/fetch_search_history_use_case.dart';
import 'package:bookly/features/search/domain/use%20cases/fetch_searched_books_use_cases.dart';
import 'package:bookly/features/search/domain/use%20cases/save_book_to_history_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBooksCubit(
        FetchSearchedBooksUseCases(getIt.get<SearchRepoImpl>()),
        FetchSearchHistoryUseCase(getIt.get<SearchRepoImpl>()),
        ClearSearchHistoryUseCase(getIt.get<SearchRepoImpl>()),
        SaveBookToHistoryUseCase(getIt.get<SearchRepoImpl>()),
      )..fetchSearchHistory(),
      child: SafeArea(child: const SearchViewBody()),
    );
  }
}
