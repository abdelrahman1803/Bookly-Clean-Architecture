import 'package:bookly/core/utilities/styles.dart';
import 'package:bookly/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:bookly/features/search/UI/views/widgets/custom_search_text_field.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            CustomSearchTextField(),
            SizedBox(height: 10),
            Text("Results:", style: Styles.textStyle20),
            SizedBox(height: 10),
            Expanded(
              child: HomeViewBody(),
              // SearchResultListView()
            ),
          ],
        ),
      ),
    );
  }
}
