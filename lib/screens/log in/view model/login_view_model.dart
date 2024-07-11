import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_taskk/screens/events/views/events_view.dart';
import 'package:test_taskk/screens/registration/view%20model/registration_view_model.dart';

class LoginController extends GetxController {
  Future<bool> logIn() async {
    try {
      Get.dialog(
        Center(
          child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 5.0,
          ),
        ),
        barrierDismissible: false,
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      Get.snackbar(
        "Login Successful",
        "You have successfully logged in.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await Future.delayed(Duration(seconds: 1)).then(
        (value) => Get.offAll(
          () => EventsScreen(),
        ),
      );

      return true;
    } catch (e) {
      print("Login error: $e");

      if (e is FirebaseAuthException) {
        Get.snackbar(
          "Login Error",
          "Invalid email or password. Please use a valid email and password.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Login Error",
          "An error occurred while logging in. Please try again later.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      return false;
    } finally {
      Get.back();
    }
  }
}
