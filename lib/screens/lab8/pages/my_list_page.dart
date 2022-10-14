// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/movie_provider.dart';
//
// class MyListPage extends StatefulWidget {
//   const MyListPage({Key? key}) : super(key: key);
//
//   @override
//   State<MyListPage> createState() => _MyListPageState();
// }
//
// class _MyListPageState extends State<MyListPage> {
//   // @override
//   Widget build(BuildContext context) {
//     var fvr8List = context.watch<MovieProvider>().myList;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My List'),
//       ),
//       body: ListView.builder(
//         itemCount: fvr8List.length,
//         padding: const EdgeInsets.all(10.0),
//         itemBuilder: (_, index) {
//           return ListTile(
//             title: Text(fvr8List[index].title),
//             subtitle: Text(fvr8List[index].runTime ?? 'No information.'),
//             trailing: TextButton(
//               onPressed: () {
//                 context.read<MovieProvider>().removeFromList(fvr8List[index]);
//               },
//               child: const Text(
//                 'Remove',
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
