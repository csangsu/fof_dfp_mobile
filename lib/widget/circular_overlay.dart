import 'package:flutter/material.dart';

class MessageOverlay extends StatelessWidget {
  const MessageOverlay({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(
              message,
            ),
          ],
        ),
      );
}
