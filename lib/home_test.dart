import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:house_of_genuises/video_player_test.dart';
import 'package:path_provider/path_provider.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({super.key});

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  List<String> savedVideoPaths = [];
  @override
  void initState() {
    try {
      getApplicationDocumentsDirectory().then((value) {
        var files = Directory(value.path).listSync();
        savedVideoPaths = files
            .where((file) => file.path.endsWith('.mp4'))
            .map((file) => file.path)
            .toList();
        print(" this is : ${savedVideoPaths.length}");
        // setState(() {});
      });
    } catch (e) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              if (savedVideoPaths.isNotEmpty) {
                print("zzz");
                Get.to(VideoPlayerScreen(
                  videoPath: savedVideoPaths[0],
                ));
              }
            },
            child: Text("press me")),
      ),
    );
  }
}
