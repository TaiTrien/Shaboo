// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:shaboo/constants.dart';
// import 'package:shaboo/screens/post/take_photo/take_photo_controller.dart';

// class TakePhotoScreen extends StatefulWidget {
//   const TakePhotoScreen({
//     Key key,
//   }) : super(key: key);

//   @override
//   TakePhotoScreenState createState() => TakePhotoScreenState();
// }

// class TakePhotoScreenState extends State<TakePhotoScreen> {
//   TakePhotoController _controller;
//   String imagePath = '';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_controller == null) _controller = TakePhotoController(context: context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Take your book picture'),
//         backgroundColor: kPrimaryColor,
//         leading: IconButton(
//           onPressed: _controller.toReturn,
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: Stack(
//         children: [
//           FutureBuilder<void>(
//             future: _controller.initCamera(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done)
//                 return CameraPreview(_controller.cameraController);
//               else
//                 return Center(child: CircularProgressIndicator());
//             },
//           ),
//           Positioned(
//             bottom: 0,
//             right: 0,
//             left: 0,
//             child: Container(
//               width: double.infinity,
//               height: 80,
//               color: Colors.black.withOpacity(0.4),
//               child: Row(
//                 children: [
//                   SizedBox(width: 10),
//                   GestureDetector(
//                     onTap: imagePath.isEmpty ? () => {} : _controller.onAccessPhotos,
//                     child: Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(5),
//                         image: imagePath.isEmpty ? null : DecorationImage(image: FileImage(File(imagePath)), fit: BoxFit.cover),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.white,
//         child: Icon(Icons.camera_alt, color: Colors.black),
//         onPressed: () async {
//           var result = await _controller.takePhoto();
//           setState(() => imagePath = result);
//         },
//       ),
//     );
//   }
// }
