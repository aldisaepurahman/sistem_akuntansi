import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';

class ButtonHide extends StatefulWidget {
  final Color bg_color;
  final Color text_color;
  final String content;

  const ButtonHide(
      {Key? key,
      required this.bg_color,
      required this.text_color,
      required this.content})
      : super(key: key);

  @override
  State<ButtonHide> createState() => ButtonHideState();
}

class ButtonHideState extends State<ButtonHide> {
  bool show = false;

  void showToast() {
    setState(() {
      show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: widget.bg_color, padding: EdgeInsets.all(18)),
        onPressed: showToast,
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
                  widget.content,
                  style: TextStyle(
                    fontFamily: "Inter",
                    color: widget.text_color,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

class ButtonNoIcon extends StatelessWidget {
  final Color bg_color;
  final Color text_color;
  final VoidCallback? onPressed;
  final String content;

  const ButtonNoIcon(
      {Key? key,
      required this.bg_color,
      required this.text_color,
      required this.onPressed,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: bg_color, padding: EdgeInsets.all(18)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
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

class ButtonBack extends StatelessWidget {
  final VoidCallback? onPressed;

  const ButtonBack({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: abu_transparan,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: abu_tua,
        ),
        onPressed: onPressed,
        icon: Icon(Icons.arrow_back_rounded),
        iconSize: 40,
      ),
    );
  }
}
