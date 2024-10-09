import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/on_generate_route.dart';
import 'core/themes/app_themes.dart';

Future<void> main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eGrocery',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.login,
    );
  }
}
