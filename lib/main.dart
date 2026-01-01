import 'package:bookly/constants.dart';
import 'package:bookly/core/utilities/functions/bloc_observer.dart';
import 'package:bookly/core/utilities/routing/app_router.dart';
import 'package:bookly/core/utilities/services%20locator/dependency_injection.dart';
import 'package:bookly/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/features/home/domain/entities/book_entity.dart';
import 'package:bookly/features/home/domain/use%20cases/fetch_featured_books_use_case.dart';
import 'package:bookly/features/home/domain/use%20cases/fetch_latest_books_use_case.dart';
import 'package:bookly/features/home/presentation/manager/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/features/home/presentation/manager/latest_books_cubit/latest_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());

  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kLatestBox);
  await Hive.openBox<BookEntity>(kSearchBox);
  await Hive.openBox<BookEntity>(kSearchHistoryBox);
  setUpGetIt();
  Bloc.observer = SimpleBlocObserver();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FeaturedBooksCubit(
              FetchFeaturedBooksUseCase(getIt.get<HomeRepoImpl>()),
            )..fetchFeaturedBooks();
          },
        ),
        BlocProvider(
          create: (context) {
            return LatestBooksCubit(
              FetchLatestBooksUseCase(getIt.get<HomeRepoImpl>()),
            )..fetchLatestBooks();
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(kPrimaryColor),
        ),
      ),
    );
  }
}
