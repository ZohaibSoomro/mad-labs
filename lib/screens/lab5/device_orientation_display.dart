// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
//
// class DeviceOrientationDisplay extends StatefulWidget {
//   const DeviceOrientationDisplay({Key? key}) : super(key: key);
//
//   @override
//   _DeviceOrientationDisplayState createState() =>
//       _DeviceOrientationDisplayState();
// }
//
// class _DeviceOrientationDisplayState extends State<DeviceOrientationDisplay> {
//   final images = [
//     const AssetImage('assets/images/1.jpg'),
//     const AssetImage('assets/images/2.jpg'),
//     const AssetImage('assets/images/3.jpg'),
//     const AssetImage('assets/images/4.jpg'),
//     const AssetImage('assets/images/5.jpg'),
//   ];
//   double x = 0, y = 0, z = 0;
//   String direction = "none";
//   int imageCounter = 0;
//
//   @override
//   void initState() {
//     gyroscopeEvents.listen((GyroscopeEvent event) {
//       debugPrint(event.toString());
//
//       x = event.x;
//       y = event.y;
//       z = event.z;
//       print("$x,$y,$z");
//       //rough calculation, you can use
//       //advance formula to calculate the orentation
//       if (x > 0) {
//         if (imageCounter < 4) {
//           imageCounter++;
//         } else {
//           imageCounter = 0;
//         }
//       } else if (x < 0) {
//         if (imageCounter > 0) {
//           imageCounter--;
//         } else {
//           imageCounter = 4;
//         }
//       } else if (y > 0) {
//         if (imageCounter < 4) {
//           imageCounter++;
//         } else {
//           imageCounter = 0;
//         }
//       } else if (y < 0) {
//         if (imageCounter > 0) {
//           imageCounter--;
//         } else {
//           imageCounter = 4;
//         }
//       }
//       setState(() {});
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Change Image With Orientation"),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.black,
//           image: DecorationImage(
//             image: images[imageCounter],
//           ),
//         ),
//       ),
//     );
//   }
// }
