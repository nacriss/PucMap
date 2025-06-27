import 'package:flutter/material.dart';
import 'package:pucmap/app_widget.dart';
import 'package:pucmap/utils/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  // Popula o banco se vazio
  await DatabaseHelper.instance.popularBancoInicial();
  runApp(const AppWidget());
}
