import 'package:bookly/core/shimmer/placeholders/featured_list_item_shimmer.dart';
import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/core/utilities/widgets/custom_error_image_widget.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FeaturedBooksListView extends StatefulWidget {
  const FeaturedBooksListView({
    super.key,
    required this.books,
    required this.onLoadMore,
    this.isLoadingMore = false,
  });

  final List<BookEntity> books;
  final ValueChanged<int> onLoadMore;
  final bool isLoadingMore;

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  late final ScrollController _scrollController;
  int _nextPage = 1;
  bool _loadMoreRequested = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_loadMoreRequested || widget.isLoadingMore) return;

    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    // Check if we've reached 70% of the scroll length
    if (currentPosition >= maxScrollExtent * 0.7) {
      _loadMoreRequested = true;
      widget.onLoadMore(_nextPage);
      _nextPage++;

      // Reset the flag after a delay to prevent multiple rapid calls
      Future.delayed(const Duration(seconds: 2), () {
        _loadMoreRequested = false;
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
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.separated(
        controller: _scrollController,
        itemCount: widget.isLoadingMore
            ? widget.books.length + 1
            : widget.books.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          // Show shimmer for loading item at the end
          if (widget.isLoadingMore && index == widget.books.length) {
            return const FeaturedListItemShimmer();
          }

          final imageUrl = widget.books[index].image ?? '';
          return GestureDetector(
            onTap: () => GoRouter.of(
              context,
            ).push(Routes.bookDetailsView, extra: widget.books[index]),
            child: widget.books.isNotEmpty
                ? CustomBookItem(imageUrl: imageUrl)
                : const ErrorImageWidget(),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
      ),
    );
  }
}
