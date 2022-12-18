import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sistem_akuntansi/utils/currency_format.dart';

class TableDashboard extends StatelessWidget {
  final tanggal;
  final nama_transaksi;
  final keterangan;
  final saldo;

  const TableDashboard(
      {super.key,
        required this.tanggal,
        required this.nama_transaksi,
        required this.keterangan,
        required this.saldo});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: greyColor10,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: EdgeInsets.all(12),
            child: SvgPicture.asset(
              keterangan == "Debit"
                  ? "assets/icons/DirectInbox.svg"
                  : "assets/icons/DirectSend.svg",
              width: 24,
              height: 24,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama_transaksi.length > 50 ? '${nama_transaksi.substring(0, 50)}...' : nama_transaksi,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  fontFamily: "Inter",
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                tanggal,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: textColor,
                  fontFamily: "Inter",
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            keterangan == "Debit" ? "+ Rp ${CurrencyFormat.convertToCurrency(saldo)}"  : "- Rp ${CurrencyFormat.convertToCurrency(saldo)}",
            style: TextStyle(
              color: keterangan == "Debit" ? greenColor : redColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}