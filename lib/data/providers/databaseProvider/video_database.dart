import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:house_of_genuises/data/models/video_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class VideoDatabase {
  static final VideoDatabase instance = VideoDatabase._init();
  static Database? _database;

  VideoDatabase._init();

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('videos.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE videos (
        courseName TEXT PRIMARY KEY,
        videoName TEXT,
        encryptedKey TEXT
      )
    ''',
    );
  }

  static Future<void> insertVideo(
      String courseName, String videoName, String key) async {
    final db = await VideoDatabase.database;

    await db.insert(
      'videos',
      {
        'courseName': courseName,
        'videoName': videoName,
        'encryptedKey': key,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // static Uint8List _encryptVideoBytes(List<int> videoBytes) {
  //   final key = Key.fromLength(32); // Generate a 256-bit encryption key
  //   final iv = IV.fromLength(16); // Generate a 128-bit initialization vector

  //   final encrypter = Encrypter(AES(key));

  //   final Uint8List uint8VideoBytes = Uint8List.fromList(videoBytes);

  //   final encrypted = encrypter.encryptBytes(uint8VideoBytes, iv: iv);

  //   return encrypted.bytes;
  // }

  static Future<List<Video>?>? getVideosByCourseName(String courseName) async {
    final db = await VideoDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query(
      'videos',
      where: 'courseName = ?',
      whereArgs: [courseName],
    );

    final List<Video> videos = [];

    for (final map in maps) {
      final video = Video.fromMap(map);
      videos.add(video);
    }

    return videos;
  }

  // static List<int> decryptVideoBytes(Uint8List encryptedBytes) {
  //   final key = Key.fromLength(32); // Generate a 256-bit encryption key
  //   final iv = IV.fromLength(16); // Generate a 128-bit initialization vector

  //   final encrypter = Encrypter(AES(key));

  //   final encrypted = Encrypted(encryptedBytes);

  //   final decrypted = encrypter.decryptBytes(encrypted, iv: iv);

  //   return decrypted;
  // }
  static final _secureStorage = FlutterSecureStorage();
  static Future<void> deleteVideo(String courseName, String courseVid) async {
    var path = await _secureStorage.read(key: 'video_$courseName-$courseVid');
    final file = File(path!);
    await file.delete();

    final db = await VideoDatabase.database;
    db.delete('videos',
        where: 'courseName = ? AND videoName = ?',
        whereArgs: [courseName, courseVid]);
    await _secureStorage.delete(key: 'video_$courseName-$courseVid');
  }
}
