import 'dart:async';

import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/features/search/UI/manager/search_books_cubit/search_books_cubit.dart';
import 'package:bookly/features/search/UI/views/widgets/custom_search_text_field.dart';
import 'package:bookly/features/search/UI/views/widgets/search_result_list_view_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  Timer? _debounce;
  String _query = '';
  String _lastRequested = '';
  bool _isDebouncing = false;

  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _triggerSearch(String raw) {
    final query = raw.trim();

    if (_query != query) {
      setState(() {
        _query = query;
      });
    }

    _debounce?.cancel();
    setState(() {
      _isDebouncing = false;
    });

    if (query.isEmpty) {
      context.read<SearchBooksCubit>().fetchSearchHistory();
      return;
    }

    if (query.length < 2) {
      return;
    }

    context.read<SearchBooksCubit>().fetchSearchedBooks(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchTextField(
              controller: _controller,
              showClearButton: _controller.text.trim().isNotEmpty,
              onClear: () {
                _debounce?.cancel();
                _lastRequested = '';
                _controller.clear();
                _triggerSearch('');
              },
              onChanged: (value) {
                final query = value.trim();

                if (_query != query) {
                  setState(() {
                    _query = query;
                  });
                }

                _debounce?.cancel();
                if (query.isEmpty) {
                  setState(() {
                    _isDebouncing = false;
                  });
                  context.read<SearchBooksCubit>().fetchSearchHistory();
                  return;
                }

                if (query.length < 2) {
                  setState(() {
                    _isDebouncing = false;
                  });
                  return;
                }

                setState(() {
                  _isDebouncing = true;
                });

                _debounce = Timer(const Duration(milliseconds: 500), () {
                  if (!mounted) return;
                  if (_lastRequested == query) return;
                  _lastRequested = query;
                  setState(() {
                    _isDebouncing = false;
                  });
                  context.read<SearchBooksCubit>().fetchSearchedBooks(query);
                });
              },
              onSubmitted: _triggerSearch,
            ),
            if (_isDebouncing)
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text('Searching…', style: Styles.textStyle14),
              ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _query.isEmpty ? 'History:' : 'Results:',
                  style: Styles.textStyle20,
                ),
                const Spacer(),
                if (_query.isEmpty)
                  BlocBuilder<SearchBooksCubit, SearchBooksState>(
                    buildWhen: (previous, current) =>
                        current is SearchBooksHistorySuccess,
                    builder: (context, state) {
                      final canClear =
                          state is SearchBooksHistorySuccess &&
                          state.bookHistory.isNotEmpty;
                      if (!canClear) return const SizedBox.shrink();
                      return TextButton(
                        onPressed: () {
                          context.read<SearchBooksCubit>().clearSearchHistory();
                        },
                        child: const Text('Clear'),
                      );
                    },
                  ),
              ],
            ),
            Text(
              _query.isEmpty ? '' : 'Results for "$_query"',
              style: Styles.textStyle14,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _query.isNotEmpty && _query.length < 2
                  ? const Center(
                      child: Text(
                        'Type at least 2 characters',
                        style: Styles.textStyle16,
                      ),
                    )
                  : const SearchResultListViewBlocBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}
