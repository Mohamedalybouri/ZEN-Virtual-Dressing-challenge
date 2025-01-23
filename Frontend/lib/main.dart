import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zen_virtual_dressing/controllers/home_controller.dart';
import 'package:zen_virtual_dressing/pages/authentication/login_page.dart';
import 'package:zen_virtual_dressing/pages/authentication/register_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}