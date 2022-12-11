import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardSaldo extends StatelessWidget {
  final String total;
  final Color fontColor;
  final Color bgColor;
  final String textCard;

  const CardSaldo({
    super.key,
    required this.total,
    required this.fontColor,
    required this.bgColor,
    required this.textCard,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        padding: EdgeInsetsDirectional.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/EmptyWallet.svg",
              height: 24,
              width: 24,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              textCard,
              style: TextStyle(
                color: fontColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              total,
              style: TextStyle(
                color: fontColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}