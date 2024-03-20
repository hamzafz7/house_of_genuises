import 'dart:io';
import 'package:aes_crypt_null_safe/aes_crypt_null_safe.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class EncryptData {
  static Future<File> fileFromUrl(String path) async {
    final url = Uri.parse(path);
    print(url);
    final http.Response responseData = await http.get(url);
    Uint8List uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    print(buffer);
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();
    print("${tempDir.path}/${path.split("/").last.split("?")[0]}");
    File file = await File(
            '${tempDir.path}/${path.split("/").last.split("?")[0]}')
        .writeAsBytes(
            buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  static String? encrypt_file(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String? encFilepath;
    try {
      encFilepath = crypt.encryptFileSync(path);
      print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath');
    } on AesCryptDataException catch (e) {
      if (e.runtimeType == AesCryptExceptionType.destFileExists) {
        print('The encryption has been completed unsuccessfully.');
      } else {
        print("error");
        return 'ERROR';
      }
    }
    return encFilepath;
  }

  static String? decrypt_file(String path) {
    AesCrypt crypt = AesCrypt();
    crypt.setOverwriteMode(AesCryptOwMode.on);
    crypt.setPassword('my cool password');
    String? decFilepath;
    try {
      decFilepath = crypt.decryptFileSync(path);
      print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path);
    } on AesCryptDataException catch (e) {
      if (e.runtimeType == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      } else {
        return 'ERROR';
      }
    }
    return decFilepath;
  }
}
