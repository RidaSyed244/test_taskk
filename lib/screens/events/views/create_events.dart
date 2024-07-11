import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_taskk/colors/Colors.dart';
import 'package:test_taskk/screens/events/view%20model/events_view_model.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _controller = Get.put(EventsController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        print("date: $selectedDate");
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        print("date: $selectedTime");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBGcolor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        backgroundColor: AppColors.appBGcolor,
        centerTitle: true,
        title: Text(
          'Create a new Event',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Event Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: eventNmae,
                decoration: InputDecoration(
                  hintText: "Team shA79",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Description",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: eventDescription,
                decoration: InputDecoration(
                  hintText:
                      "A text area or rich text editor for entering detailed description for completing the task",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Instructions",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: eventInstruction,
                decoration: InputDecoration(
                  hintText:
                      "A text area or rich text editor for entering detailed instructions for completing the task",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "Select Date",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedTime != null
                                ? "${selectedTime!.hour}:${selectedTime!.minute}"
                                : "Select Time",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_drop_down,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextField(
                controller: eventLocation,
                decoration: InputDecoration(
                  hintText: "XXYYZZ",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.location_history, color: Colors.black),
                  Text(
                    "Use current location",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.080),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.070,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    " Upload PDF",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  bool result = await _controller.addEventsToDB();
                  print("Event add result: $result");
                },
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.070,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.black),
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      " Confirm & Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
