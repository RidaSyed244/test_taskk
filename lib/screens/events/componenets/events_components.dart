import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:test_taskk/screens/events/views/create_events.dart';

bool _visible = true;
void speeddialvisible(bool value) {
  _visible = value;
}

buildspeedDial(context) => SpeedDial(
      backgroundColor: Colors.black,
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(color: Colors.white),
      onOpen: () => print("Open"),
      onClose: () => print("Close"),
      curve: Curves.easeInBack,
      visible: _visible,
      children: [
        SpeedDialChild(
            backgroundColor: Colors.white,
            child: Icon(Icons.message, color: Colors.black),
            label: "New message",
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
        SpeedDialChild(
            backgroundColor: Colors.white,
            child: Icon(Icons.insert_invitation, color: Colors.black),
            label: "Team Invite",
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
        SpeedDialChild(
            backgroundColor: Colors.white,
            child: Icon(Icons.task, color: Colors.black),
            label: "Create Task",
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
        SpeedDialChild(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CreateEvent())),
            backgroundColor: Colors.white,
            child: Icon(Icons.event, color: Colors.black),
            label: "Create Event",
            labelBackgroundColor: Colors.white,
            labelStyle: TextStyle(color: Colors.black, fontSize: 15)),
      ],
    );
