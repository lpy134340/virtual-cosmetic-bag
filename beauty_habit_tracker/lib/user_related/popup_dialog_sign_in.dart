import 'package:flutter/material.dart';

class PopupDialog extends StatefulWidget {
  const PopupDialog({super.key, required this.errMsg});
  final String errMsg;

  @override
  State<PopupDialog> createState() => _PopupDialogState();
}

class _PopupDialogState extends State<PopupDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sign-in Error', semanticsLabel: 'Sign-in Error'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.errMsg),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close', semanticsLabel: 'Close'),
        ),
      ],
    );
  }
}
