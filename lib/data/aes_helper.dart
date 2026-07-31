import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AesHelper {
  static final _key = encrypt.Key.fromUtf8(dotenv.env["AES_KEY"] ?? "");

  static final _encrypter = encrypt.Encrypter(
    encrypt.AES(_key, mode: encrypt.AESMode.cbc)
  );

  static String encryptText(String plainText){
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypted = _encrypter.encrypt(plainText, iv: iv);
    final combined = Uint8List.fromList([...iv.bytes, ...encrypted.bytes]);
    return encrypt.Encrypted(combined).base64;
  }

  static String decryptText(String eBase64){
    final combined = encrypt.Encrypted.fromBase64(eBase64).bytes;
    final iv = encrypt.IV(combined.sublist(0, 16));

    final encrypted = encrypt.Encrypted(combined.sublist(16));
    return _encrypter.decrypt(encrypted, iv: iv);
  }
}