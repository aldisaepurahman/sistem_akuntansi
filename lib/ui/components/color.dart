import 'package:flutter/material.dart';

final hitam = Color.fromARGB(255, 50, 52, 55); //hitam
final kuning = Color.fromARGB(255, 255, 204, 0); //kuning
final background = Color.fromARGB(255, 248, 249, 253); //brokenwhite
final background2 = Color.fromARGB(255, 255, 255, 255); //white
final abu_tua = Color.fromARGB(255, 117, 117, 117);
final abu_transparan = Color.fromARGB(50, 117, 117, 117);
final merah = Color.fromARGB(255, 245, 0, 0);

int replaceColor(String color){
  return int.parse(color.replaceAll('#', '0xff'));
}

Color textColor = Color(replaceColor("#0f0c00"));
Color yellowTextColor = Color(replaceColor("#ffcc00"));
Color whiteColor = Color(replaceColor("#ffffff"));
Color greyColor10 = Color(replaceColor("#f8f9fd"));
Color greyFontColor = Color(replaceColor("#b7b7b7"));
Color greyHeaderColor = Color(replaceColor("#f5f5f5"));
Color greenColor = Color(replaceColor("#00dea3"));
Color redColor = Color(replaceColor("#ce2342"));



// Color yellowPrime = Color(0XFFFFCC00);
// Color textColor = Color(0XFF0F0C00);
// Color greyColor = Color(0XFFB7B7B7);
// Color greenColor = Color(0XFF00DEA3);
// Color redColor = Color(0XFFCE2342);
// Color greyColor10 = Color(0XFFF8F9FD);