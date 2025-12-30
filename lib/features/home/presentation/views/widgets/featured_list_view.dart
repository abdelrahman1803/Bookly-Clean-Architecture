import 'package:bookly/core/shimmer/placeholders/featured_list_item_shimmer.dart';
import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/core/utilities/widgets/custom_error_image_widget.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({super.key, required this.books});

  final List<BookEntity> books;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late final ScrollController _scrollController;
  int _nextPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    // Check if we've reached 70% of the scroll length
    if (currentPosition >= maxScrollExtent * 0.7) {
      _isLoadingMore = true;
      context.read<FeaturedBooksCubit>().fetchFeaturedBooks(
        pageNumber: _nextPage,
      );
      _nextPage++;

      // Reset the flag after a delay to prevent multiple rapid calls
      Future.delayed(const Duration(seconds: 2), () {
        _isLoadingMore = false;
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
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        if (state is FeaturedBooksSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: ListView.separated(
              controller: _scrollController,
              itemCount: state.isLoadingMore
                  ? widget.books.length + 1
                  : widget.books.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                // Show shimmer for loading item at the end
                if (state.isLoadingMore && index == widget.books.length) {
                  return const FeaturedListItemShimmer();
                }

                final imageUrl = widget.books[index].image ?? '';
                return GestureDetector(
                  onTap: () => GoRouter.of(
                    context,
                  ).push(Routes.bookDetailsView, extra: state.books[index]),
                  child: widget.books.isNotEmpty
                      ? CustomBookItem(imageUrl: imageUrl)
                      : const ErrorImageWidget(),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
