import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final header;
  final content;

  const DetailText({Key? key, required this.header, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 20),
          child: Text(header,
              style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 14,
                  color: Color.fromARGB(255, 50, 52, 55))),
        ),
        Text(content,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
                fontSize: 14,
                color: Color.fromARGB(255, 50, 52, 55)))
      ],
    );
  }
}
