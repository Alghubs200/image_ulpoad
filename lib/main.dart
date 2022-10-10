import 'dart:io';
import 'package:get/get.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_ulpoad/image_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ImageController());
    return const MaterialApp(
      title: 'Image Upload',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Image Upload'),
        ),
        body: GetBuilder<ImageController>(builder: (ImageController) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Center(
                child: GestureDetector(
                  child: const Text('Select an Image'),
                  onTap: (() => ImageController.pickImage()),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: ImageController.pickedFile != null
                      ? Image.file(
                          File(ImageController.pickedFile!.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Text('Please Select an Image'))
            ]),
          ));
        }));
  }
}
