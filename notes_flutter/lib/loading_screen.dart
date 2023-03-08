import 'package:flutter/material.dart';

/// Displays a progress indicator when we are loading notes from the server. Or
/// a button to try again if the connection to the server failed.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    this.exception,
    required this.onTryAgain,
    super.key,
  });

  final Exception? exception;
  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    if (exception != null) {
      return Center(
        child: ElevatedButton(
          onPressed: onTryAgain,
          child: const Text('Try again'),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
