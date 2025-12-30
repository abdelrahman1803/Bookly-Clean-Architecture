import 'package:bookly/core/utilities/routing/routes.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/presentation/views/book_details_view.dart';
import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:bookly/features/search/UI/search_view.dart';
import 'package:bookly/features/splash/UI/views/splash_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      // Splash View Route
      GoRoute(
        path: Routes.splashView,
        builder: (context, state) => const SplashView(),
      ),
      // Home View Route
      GoRoute(
        path: Routes.homeView,
        builder: (context, state) => const HomeView(),
      ),
      // Book Details View Route
      GoRoute(
        path: Routes.bookDetailsView,
        builder: (context, state) =>
            BookDetailsView(book: state.extra as BookEntity),
      ),
      // Search View Route
      GoRoute(
        path: Routes.searchView,
        builder: (context, state) => const SearchView(),
      ),
    ],
  );
}
