import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<List<String>> uploadFotos(List<File> imagens, String nomePredio) async {
  List<String> urls = [];
  for (var i = 0; i < imagens.length; i++) {
    final ref = FirebaseStorage.instance.ref().child('predios/$nomePredio/img$i.jpg');
    final upload = await ref.putFile(imagens[i]);
    final url = await upload.ref.getDownloadURL();
    urls.add(url);
  }
  return urls;
}
