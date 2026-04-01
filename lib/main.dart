import 'package:flutter/material.dart';
import 'package:flutter_mvp32/ui/screens/home/home_view.dart';
import 'package:flutter_mvp32/ui/screens/home/home_viewmodel.dart';

import 'core/theme_controller.dart';
import 'data/repositories/user_repository.dart';
import 'data/services/api_service.dart';
import 'package:get/get.dart';

void main() {
  final apiService = ApiService();
  final repository = UserRepository(apiService);

  Get.put(HomeViewModel(repository));
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(()=>GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      themeMode: themeController.theme,
      home: HomeView(),
    ));
  }
}

