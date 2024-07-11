import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_taskk/screens/events/views/events_view.dart';
import 'package:test_taskk/screens/log%20in/views/log_in_view.dart';

final eventNmae = TextEditingController();
final eventDescription = TextEditingController();
final eventInstruction = TextEditingController();
final eventLocation = TextEditingController();

DateTime? selectedDate;
TimeOfDay? selectedTime;

class EventsController extends GetxController {
  Future<void> logOut() async {
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

      await FirebaseAuth.instance.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('email');
      Get.snackbar(
        "Logout Successful",
        "You have successfully logged out.",
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
      print("Logout error: $e");

      Get.snackbar(
        "Logout Error",
        "An error occurred while logging out. Please try again later.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      Get.back();
    }
  }

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formatTime(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return '';
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('HH:mm').format(dateTime);
  }

  Future addEventsToDB() async {
    if (eventNmae.text.isEmpty ||
        eventDescription.text.isEmpty ||
        eventInstruction.text.isEmpty ||
        eventLocation.text.isEmpty ||
        selectedDate == null ||
        selectedTime == null) {
      Get.snackbar(
        "Validation Error",
        "All fields are required",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

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

      await FirebaseFirestore.instance.collection("Events").add({
        "eventName": eventNmae.text,
        "eventDescription": eventDescription.text,
        "eventInstruction": eventInstruction.text,
        "eventLocation": eventLocation.text,
        "eventDate": formatDate(selectedDate),
        "eventTime": formatTime(selectedTime),
      });

      Get.snackbar(
        "Success",
        "Event added successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await Future.delayed(Duration(seconds: 1)).then(
        (value) => Get.offAll(
          () => EventsScreen(),
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error adding event: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      Get.back();
    }
  }
}
