// import 'package:flutter/material.dart';
// import 'package:lab2_task/screens/lab8/pages/my_list_page.dart';
// import 'package:lab2_task/screens/lab8/provider/movie_provider.dart';
// import 'package:provider/provider.dart';
//
// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     var movies = context.watch<MovieProvider>().movies;
//     var fvr8List = context.watch<MovieProvider>().myList;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider example'),
//         actions: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const MyListPage()));
//             },
//             child: const Text(
//               'Go to My list',
//             ),
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: movies.length,
//         padding: const EdgeInsets.all(10.0),
//         itemBuilder: (_, index) {
//           return ListTile(
//             title: Text(movies[index].title),
//             subtitle: Text(movies[index].runTime ?? 'No information.'),
//             trailing: IconButton(
//               onPressed: () {
//                 context.read<MovieProvider>().addToList(movies[index]);
//               },
//               icon: Icon(
//                 Icons.favorite,
//                 color:
//                     fvr8List.contains(movies[index]) ? Colors.red : Colors.grey,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
