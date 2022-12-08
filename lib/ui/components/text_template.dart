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

class HeaderText extends StatelessWidget {
  final content;
  final double size;
  final color;

  const HeaderText(
      {Key? key,
      required this.content,
      required this.size,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        content,
        style: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.bold,
            fontSize: size,
            color: color),
      ),
    );
  }
}

class HeaderTable extends StatelessWidget {
  final content;

  const HeaderTable({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(content,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: "Inter", fontWeight: FontWeight.bold)),
    );
  }
}
