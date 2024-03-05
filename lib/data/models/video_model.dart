class Video {
  final String courseName;
  final String videoName;
  final String key;

  Video({required this.courseName, required this.videoName, required this.key});

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      courseName: map['courseName'],
      videoName: map['videoName'],
      key: map['encryptedKey'],
    );
  }
}
