import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('404 - Page not found with uri: $uri'),
      ),
    );
  }
}
