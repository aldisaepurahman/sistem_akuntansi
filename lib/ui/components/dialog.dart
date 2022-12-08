import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class Dialog2Button extends StatelessWidget {
  final String content_detail;
  final String content;
  final String path_image;
  final String button1;
  final String button2;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const Dialog2Button(
      {Key? key,
      required this.content,
      required this.content_detail,
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
        width: 320,
        height: 350,
        child: Column(
          children: [
            Center(
                child: Image.asset(
              path_image,
              fit: BoxFit.contain,
            )),
            SizedBox(height: 25),
            Text(
              textAlign: TextAlign.center,
              content,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              content_detail,
              style: TextStyle(fontSize: 13, fontFamily: "Inter"),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(
                    onPressed: onPressed1,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: background2,
                        padding: EdgeInsets.all(20)),
                    child: Text(button1, style: TextStyle(color: kuning))),
                ElevatedButton(
                  onPressed: onPressed2,
                  child: Text(
                    button2,
                    style: TextStyle(color: hitam),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kuning, padding: EdgeInsets.all(20)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogNoButton extends StatelessWidget {
  final String content;
  final String content_detail;
  final String path_image;

  const DialogNoButton(
      {Key? key,
      required this.content,
      required this.content_detail,
      required this.path_image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: background2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 120,
        padding: EdgeInsets.all(50),
        height: 330,
        child: Column(
          children: [
            Center(
                child: Image.asset(
              path_image,
              fit: BoxFit.contain,
            )),
            SizedBox(height: 35),
            Text(
              textAlign: TextAlign.center,
              content,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              textAlign: TextAlign.center,
              content_detail,
              style: TextStyle(fontSize: 13, fontFamily: "Inter"),
            )
          ],
        ),
      ),
    );
  }
}
