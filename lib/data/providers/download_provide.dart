import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cr_file_saver/file_saver.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:house_of_genuises/data/providers/encrypt.dart';
import 'package:mime/mime.dart';
// import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DownloadProvider with ChangeNotifier {
  bool isDownloading = false;
  int? downloadId;
  late String localPath;

  Future<void> prepareSaveDir() async {
    localPath = (await findLocalPath())!;
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
    return;
  }

  Future<String?> findLocalPath() async {
    var externalStorageDirPath;
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
    return externalStorageDirPath;
  }

  Future<bool> requestStoragePermissions() async {
    var storagePermissionIsGranted = false;

    final storageReq = await Permission.storage
        .request(); // required for android before 9 (SDK 28)
    print(
        'requestStoragePermissions storageReq  ${storageReq.name} ${storageReq.isGranted}');
    storagePermissionIsGranted = storageReq.isGranted;
    if (!storagePermissionIsGranted) {
      final manageExternalStorageReq = await Permission.manageExternalStorage
          .request(); // required for android after 9 (SDK 28)
      print(
          'requestStoragePermissions manageExternalStorageReq ${manageExternalStorageReq.name} ${manageExternalStorageReq.isGranted}');
      storagePermissionIsGranted = manageExternalStorageReq.isGranted;
    }

    final accessMediaLocationReq =
        await Permission.accessMediaLocation.request();
    print(
        'requestStoragePermissions accessMediaLocationReq ${accessMediaLocationReq.name} ${accessMediaLocationReq.isGranted}');

    final mediaLibraryReq = await Permission.mediaLibrary.request();
    print(
        'requestStoragePermissions mediaLibraryReq ${mediaLibraryReq.name} ${mediaLibraryReq.isGranted}');

    final microphoneReq = await Permission.microphone.request();
    print(
        'requestStoragePermissions microphoneReq ${microphoneReq.name} ${microphoneReq.isGranted}');

    final cameraReq = await Permission.camera.request();
    print(
        'requestStoragePermissions cameraReq ${cameraReq.name} ${cameraReq.isGranted}');

    final audioReq = true; //await Permission.audio.request();
    // print('requestStoragePermissions audioReq ${audioReq.name} ${audioReq.isGranted}');
    final videosReq = true; // await Permission.videos.request();
    //print('requestStoragePermissions videosReq ${videosReq.name} ${videosReq.isGranted}');
    final photosReq = true; //await Permission.photos.request();
    // print('requestStoragePermissions photosReqReq ${photosReq.name} ${photosReq.isGranted}');

    // final isIos = Platform.isIOS;
    // if(isIos)

    // var photosIsGranted = isIos
    //   ? await Permission.photos.isGranted
    //   : true;
    // var photosIsGranted = await Permission.photos.isGranted;

    var isGranted = storagePermissionIsGranted &&
        accessMediaLocationReq.isGranted &&
        mediaLibraryReq.isGranted &&
        microphoneReq.isGranted &&
        cameraReq.isGranted;
    //photosIsGranted;
    return isGranted;
  }

  String getFileExtension(String url) {
    final extension = path.extension(url);
    print(extension);
    return extension.isNotEmpty ? extension.substring(1) : '';
  }

  Future download(String url, String name) async {
    try {
      isDownloading = true;

      print('sssssss');
      final s = await CRFileSaver.requestWriteExternalStoragePermission();

      File file = await EncryptData.fileFromUrl(url);
      print("--------------");
      print(file.path);
      final ecryptedPath = EncryptData.encrypt_file(file.path);

      final String uniqueName = '$name${DateTime.now().millisecond.toString()}';

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$uniqueName';
      print("directory:");
      print(directory.path);
      print(directory.absolute.path);
      print(filePath);

      // Read the encrypted file as bytes
      final encryptedFile = File(ecryptedPath!);
      Uint8List bytes = await encryptedFile.readAsBytes();

      // Save the encrypted file to the document directory
      final savedFile = File(filePath);
      await savedFile.writeAsBytes(bytes);
      print(savedFile.path);
      print("sucess");

      isDownloading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }
}
