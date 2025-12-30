// import 'package:bookly/features/home/presentation/views/widgets/book_list_view_item.dart';
// import 'package:flutter/material.dart';

// class SearchResultListView extends StatelessWidget {
//   const SearchResultListView({super.key});

//   static const _results = [
//     {
//       'title': 'Search Result One',
//       'author': 'Author One',
//       'price': 'Free',
//       'image':
//           'https://images.unsplash.com/photo-1529070538774-1843cb3265df?w=400',
//     },
//     {
//       'title': 'Search Result Two',
//       'author': 'Author Two',
//       'price': '6.00',
//       'image':
//           'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=400',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: EdgeInsets.zero,
//       itemCount: _results.length,
//       itemBuilder: (BuildContext context, int index) {
//         final item = _results[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0),
//           child: BookListViewItem(
//            book: item,
//           ),
//         );
//       },
//     );
//   }
// }
