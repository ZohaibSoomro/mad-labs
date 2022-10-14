// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(25.3960, 68.3578);
//   LatLng currentPosition = const LatLng(25.408806, 68.262287);
//   Set<Marker>? markers;
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     setCurrentLocation();
//   }
//
//   setCurrentLocation() async {
//     try {
//       print('${currentPosition.latitude},${currentPosition.longitude}');
//       markers = {
//         Marker(
//           markerId: const MarkerId('1'),
//           position: _center,
//           infoWindow: InfoWindow(
//             title: 'Hyderabad',
//             snippet: '${_center.latitude},${_center.longitude}',
//           ),
//         ),
//         Marker(
//           markerId: const MarkerId('1'),
//           position: currentPosition,
//           infoWindow: InfoWindow(
//             title: '19Sw42',
//             snippet: '${currentPosition.latitude},${currentPosition.longitude}',
//           ),
//         ),
//       };
//     } catch (e) {
//       debugPrint("Error: $e");
//     }
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Lab06 task2'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           markers: markers ?? {},
//           initialCameraPosition: CameraPosition(
//             target: markers != null ? currentPosition : _center,
//             zoom: 11.0,
//           ),
//         ),
//       ),
//     );
//   }
// }
