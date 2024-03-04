import 'dart:typed_data';

import 'package:house_of_genuises/data/providers/databaseProvider/video_database.dart';

class Video {
  final String courseName;
  final String videoName;
  final Uint8List encryptedVideoBytes;

  Video(
      {required this.courseName,
      required this.videoName,
      required this.encryptedVideoBytes});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      courseName: map['courseName'],
      videoName: map['videoName'],
      encryptedVideoBytes: map['encryptedVideoBytes'],
    );
  }
  Future<List<int>> getDecryptedVideoBytes() async {
    final videoBytes =
        await VideoDatabase.decryptVideoBytes(encryptedVideoBytes);
    return videoBytes;
  }
}
