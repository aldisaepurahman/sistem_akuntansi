import 'package:flutter/material.dart';

class RowContent extends StatelessWidget {
  final content;

  const RowContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Text(content,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "Inter", color: Color.fromARGB(255, 50, 52, 55))));
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 0),
                padding: EdgeInsets.all(20)),
            onPressed: () {},
            child: Text(
              "Lihat Detail",
              style: TextStyle(
                  fontFamily: "Inter",
                  color: Color.fromARGB(255, 50, 52, 55),
                  fontWeight: FontWeight.bold),
            )));
  }
}
