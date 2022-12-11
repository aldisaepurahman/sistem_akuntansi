import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';

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
        width: 150,
        padding: EdgeInsets.all(50),
        height: 360,
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

class DialogPenyusutan extends StatelessWidget {
  final String penyusutan;
  final TextEditingController persentase;
  final VoidCallback? onPressed;

  const DialogPenyusutan(
      {Key? key,
      required this.penyusutan,
      required this.persentase,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: background2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 400,
        padding: EdgeInsets.all(50),
        height: 400,
        child: Column(
          children: [
            HeaderText(content: "Form Penyusutan", size: 17, color: hitam),
            SizedBox(height: 25),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style:
                    TextStyle(fontFamily: "Inner", fontSize: 15, color: hitam),
                children: <TextSpan>[
                  TextSpan(text: "Nilai Penyusutan dalam bulan ini sebesar"),
                  TextSpan(
                      text: " Rp" + penyusutan,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inner",
                          fontSize: 15,
                          color: hitam)),
                  TextSpan(
                      text:
                          ". Apakah Anda ingin menggunakan 100% nilai penyusutan ini? Jika tidak, masukkan persentase penggunaan nilai penyusutan yang baru.")
                ],
              ),
            ),
            SizedBox(height: 15),
            TextForm(
                hintText: "Masukkan persentase (dalam %)",
                textController: persentase),
            ButtonNoIcon(
                bg_color: kuning,
                text_color: hitam,
                onPressed: onPressed,
                content: "Simpan")
          ],
        ),
      ),
    );
  }
}
