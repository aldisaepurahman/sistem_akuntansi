import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class Dialog2Button extends StatelessWidget {
  final String content;
  final String path_image;
  final String button1;
  final String button2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const Dialog2Button(
      {Key? key,
      required this.content,
      required this.path_image,
      required this.button1,
      required this.button2,
      required this.onPressed1,
      required this.onPressed2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: background2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
                child: Image.asset(
              path_image,
              fit: BoxFit.contain,
            )),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(onPressed: onPressed1, child: Text(button1)),
                ElevatedButton(onPressed: onPressed2, child: Text(button2))
              ],
            )
          ],
        ),
      ),
    );
  }
}
