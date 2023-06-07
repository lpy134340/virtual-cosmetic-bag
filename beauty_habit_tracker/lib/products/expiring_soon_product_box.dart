import 'package:flutter/material.dart';

class ExpiringSoonProductBox extends StatefulWidget {
  const ExpiringSoonProductBox({super.key});
  // final String title;

  @override
  State<ExpiringSoonProductBox> createState() => _ExpiringSoonProductBoxState();
}

class _ExpiringSoonProductBoxState extends State<ExpiringSoonProductBox> {
  final int productsToDisplay = 6;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
      const ListTile(
        title: Text("Product Name"),
        subtitle: Text("EXD:"),
      ),
      Ink.image(
        image: const NetworkImage(
            'https://source.unsplash.com/random/800x600?house'),
        fit: BoxFit.cover,
      )
    ]));
  }
}
