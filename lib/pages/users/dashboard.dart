import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
 
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
   return Center(
      child: Container(
          child: Text(
        'Dashboard',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
        color: Colors.cyan),
      )),
    );
  }
}