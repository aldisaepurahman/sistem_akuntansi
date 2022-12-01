import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class Button extends StatelessWidget {
  final Color bg_color;
  final Color text_color;
  final Function onPressed;
  final String content;
  final Icon icon;

  const Button(
      {Key? key,
      required this.bg_color,
      required this.text_color,
      required this.onPressed,
      required this.content,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bg_color, padding: EdgeInsets.all(18)),
        onPressed: () {
          onPressed(content);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.add,
                  size: 13,
                  color: hitam,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  content,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: text_color,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
