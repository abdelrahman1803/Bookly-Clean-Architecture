import 'package:bookly/constants.dart';
import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/features/home/presentation/manager/latest_books_cubit/latest_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:bookly/features/home/presentation/views/widgets/featured_list_view_bloc_builder.dart';
import 'package:bookly/features/home/presentation/views/widgets/latest_books_bloc_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late final ScrollController _scrollController;
  int _nextLatestPage = 1;
  bool _latestLoadRequested = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (_latestLoadRequested) return;

    final position = _scrollController.position;
    final currentPosition = position.pixels;
    final maxScrollExtent = position.maxScrollExtent;

    if (maxScrollExtent == 0) return;

    // When reaching ~70% of the overall scroll, load next latest-books page.
    if (currentPosition >= maxScrollExtent * 0.7) {
      final state = context.read<LatestBooksCubit>().state;
      if (state is! LatestBooksSuccess || state.isLoadingMore) return;

      _latestLoadRequested = true;
      context.read<LatestBooksCubit>().fetchLatestBooks(
        pageNumber: _nextLatestPage,
      );
      _nextLatestPage++;

      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        _latestLoadRequested = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: kPaddingSH16, child: CustomAppBar()),
              FeaturedBooksListViewBlocBuilder(),
              const SizedBox(height: 36),
              Padding(
                padding: kPaddingSH16,
                child: Text(
                  "Latest Books",
                  style: Styles.textStyle20.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: kPaddingSH16,
            child: LatestBooksBlocBuilder(),
          ),
        ),
      ],
    );
  }
}
