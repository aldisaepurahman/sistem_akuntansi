import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:sistem_akuntansi/utils/Buku_besar.dart';

class BulanTahunTableData extends DataTableSource {
  Function seeDetail;
  BuildContext context;
  BulanTahunTableData({required List<V_bulan_jurnal> contentData, required this.seeDetail, required this.context}) : _contentData = contentData, assert(contentData != null);
  final List<V_bulan_jurnal> _contentData;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _contentData.length) {
      return null;
    }
    final _content = _contentData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${index+1}"),
            )
        ),
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.bulan}"),
            )
        ),
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.tahun}"),
            )
        ),
        DataCell(
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 204, 0),
              padding: EdgeInsets.all(20),
            ),
            onPressed: () {
              seeDetail();
            },
            child: const Text(
              "Lihat Detail",
              style: TextStyle(
                fontFamily: "Inter",
                color: Color.fromARGB(255, 50, 52, 55),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _contentData.length;

  @override
  int get selectedRowCount => 0;
}

class BukuBesarTableData extends DataTableSource {
  BuildContext context;
  BukuBesarTableData({required List<Buku_besar> contentData, required this.context}) : _contentData = contentData, assert(contentData != null);
  final List<Buku_besar> _contentData;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _contentData.length) {
      return null;
    }
    final _content = _contentData[index];

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.tgl}"),
            )
        ),
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.nama_transaksi}"),
            )
        ),
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.no_bukti}"),
            )
        ),
        DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.keterangan}"),
            )
        ),DataCell(
            SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 50,
              child: Text("${_content.saldo}"),
            )
        ),

      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _contentData.length;

  @override
  int get selectedRowCount => 0;
}

class ActionButton extends StatelessWidget {
  final String textContent;
  VoidCallback? onPressed;

  ActionButton(
    {Key? key,
    required this.textContent,
    required this.onPressed,
    })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 0),
                padding: EdgeInsets.all(20)),onPressed: onPressed,
            child: Text(
              textContent,
              style: TextStyle(
                  fontFamily: "Inter",
                  color: Color.fromARGB(255, 50, 52, 55),
                  fontWeight: FontWeight.bold),
            )));
  }
}
