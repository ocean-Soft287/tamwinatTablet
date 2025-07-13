import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

const privateKey = 'c104780a25b4f80c037445dd1f6947e1'; //"5554f61b8e7fbb9328bf78fc707cb42c";//"054b859550eb77560b3d4c6af8897e83"; //;
const publicKey = 'e0c9de1b2de26fe2';// - tamwinat; //"dd52cb03228834eb";//cairo  -   //"b2810bb8c519327f" // mansoura;  
const signature = "g8Etyx8TU579vDxJzaN1lo3r46+WJLvqb/IMYdIURHM="; //"JS/gezZToRZmmb+UYqgNGdzj4tVdpZe2uTfwVz0xKy0="; //"Q3EAE1vKOdUEXdw7pEoA6vUoY31xPD0DvcmakCl0fE8="; //;

dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey);
  final ivObj = encrypt.IV.fromUtf8(publicKey);
  final encrypter =
      encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

  try {
    final decrypted = encrypter
        .decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
    return decrypted;
  } catch (e) {
    return 'Error....................';
  }
}

String encryptData(
    Map<String, dynamic> data, String privateKey, String publicKey) {
  final key = encrypt.Key.fromUtf8(privateKey);
  final iv = encrypt.IV.fromUtf8(publicKey);
  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc),
  );
  try {
    String jsonString = json.encode(data);
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    final encryptedText = encrypted.base64;
    return encryptedText;
  } catch (e) {
    return 'Error....................';
  }
}
