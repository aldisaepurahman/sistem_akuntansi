import 'package:sistem_akuntansi/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CardSaldo extends StatelessWidget {
  final total;

  const CardSaldo({super.key, required this.total});

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
          color: yellowPrime,
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
              "Total Saldo",
              style: TextStyle(
                color: textColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Rp " + total,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardPemasukan extends StatelessWidget {
  final total;

  const CardPemasukan({super.key, required this.total});

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
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/CardReceive.svg",
              height: 24,
              width: 24,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Total Saldo",
              style: TextStyle(
                color: greenColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "+ Rp " + total,
              style: TextStyle(
                color: greenColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardPengeluaran extends StatelessWidget {
  final total;

  const CardPengeluaran({super.key, required this.total});

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
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/icons/CardSend.svg",
              height: 24,
              width: 24,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Total Saldo",
              style: TextStyle(
                color: redColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "- Rp " + total,
              style: TextStyle(
                color: redColor,
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
