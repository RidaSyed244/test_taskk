import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_taskk/screens/splash/views/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final email = prefs.getString('email');
  print("Email: $email");
  runApp(MyApp(email: email));
}

class MyApp extends StatelessWidget {
  final String? email;
  const MyApp({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: email != null
          ? SplashScreen(email: email.toString())
          : SplashScreen(
              email: null,
            ),
    );
  }
}
