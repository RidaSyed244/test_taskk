import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_taskk/colors/Colors.dart';
import 'package:test_taskk/screens/events/componenets/events_components.dart';
import 'package:test_taskk/screens/events/view%20model/events_view_model.dart';
import 'package:test_taskk/screens/events/views/events_tab.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _controller = Get.put(EventsController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBGcolor,
      floatingActionButton: buildspeedDial(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            await _controller.logOut();
          },
          icon: Icon(Icons.logout),
          color: Colors.white,
        ),
        title: Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: 'Events'),
                      Tab(text: 'Teams'),
                      Tab(text: 'Tasks'),
                      Tab(text: 'Equipment'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                EventsTab(),
                Center(child: Text('Teams')),
                Center(child: Text('Tasks')),
                Center(child: Text('Equipment')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
