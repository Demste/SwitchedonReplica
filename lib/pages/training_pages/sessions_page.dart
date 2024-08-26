import 'package:flutter/material.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends State<SessionsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Session"),
    );
  }
}