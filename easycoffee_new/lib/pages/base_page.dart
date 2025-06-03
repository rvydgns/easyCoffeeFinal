import 'package:flutter/material.dart';
import '../components/appdrawer.dart';
import '../themes/colors.dart';

class BasePage extends StatelessWidget {
  final String title;
  final Widget content;

  const BasePage({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: primaryColor,
      ),
      drawer: const AppDrawer(),
      backgroundColor: Colors.grey[100],
      body: content,
    );
  }
}
