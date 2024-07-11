// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_taskk/screens/log%20in/views/log_in_view.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();
final repeatPasswordController = TextEditingController();

class SignUpController extends GetxController {
  RxBool isChecked = false.obs;

  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return emailRegex.hasMatch(email);
  }

  Future<void> signUpUser() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repeatPasswordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email, password, and repeat password cannot be empty",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!_validateEmail(emailController.text)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email ending with @gmail.com",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar(
        "Error",
        "Password must be at least 6 characters long",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (passwordController.text != repeatPasswordController.text) {
      Get.snackbar(
        "Error",
        "Password and repeat password do not match",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.dialog(
      Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          strokeWidth: 5.0,
        ),
      ),
      barrierDismissible: false,
    );

    try {
      UserCredential auth =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print("Auth: $auth");
      if (auth != null) {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set({
          "email": emailController.text,
          "password": passwordController.text,
          "uid": FirebaseAuth.instance.currentUser?.uid,
        });
      }
      Get.snackbar(
        "Success",
        "User registered successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      await Future.delayed(Duration(seconds: 1)).then(
        (value) => Get.offAll(
          () => LogIn(),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error registering user: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      Get.back();
    }
  }
}
