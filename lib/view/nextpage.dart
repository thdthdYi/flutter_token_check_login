import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  static String get routeName => 'nextPage';
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Next Page'),
      ),
    );
  }
}
