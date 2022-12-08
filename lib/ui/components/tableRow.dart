import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';
import 'package:sistem_akuntansi/utils/V_detail_transaksi.dart';
import 'package:sistem_akuntansi/utils/V_lookup.dart';

class RowContent extends StatelessWidget {
  final content;

  const RowContent({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Text(content,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: "Inter", color: Color.fromARGB(255, 50, 52, 55))));
  }
}

class ActionButton extends StatelessWidget {
  final String textContent;
  VoidCallback? onPressed;

  ActionButton({
    Key? key,
    required this.textContent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 0),
                padding: EdgeInsets.all(20)),
            onPressed: onPressed,
            child: Text(
              textContent,
              style: TextStyle(
                  fontFamily: "Inter",
                  color: Color.fromARGB(255, 50, 52, 55),
                  fontWeight: FontWeight.bold),
            )));
  }
}

class RowTableMonth extends DataTableSource {
  Function seeDetail;
  BuildContext context;
  RowTableMonth(
      {required List<V_bulan_jurnal> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
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
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 5 - 50,
          child: Text("${index + 1}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 5 - 50,
          child: Text("${_content.bulan}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 5 - 50,
          child: Text("${_content.tahun}"),
        )),
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

class RowTableCOA extends DataTableSource {
  Function seeDetail;
  BuildContext context;
  RowTableCOA(
      {required List<VLookup> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<VLookup> _contentData;

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
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.04 - 50,
          child: Text("${index + 1}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 5.5 - 50,
          child: Text("${_content.kode}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.3 - 50,
          child: Text("${_content.nama_akun}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.1 - 50,
          child: Text("${_content.saldo}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.04 - 50,
          child: Text("${_content.indentasi}"),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.15 - 50,
          child: ElevatedButton(
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
                  fontWeight: FontWeight.bold),
            ),
          ),
        )),
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

class RowTableDetail extends DataTableSource {
  BuildContext context;
  RowTableDetail(
      {required List<V_detail_transaksi> contentDataDebit,
      required List<V_detail_transaksi> contentDataKredit,
      required this.context})
      : _contentDataDebit = contentDataDebit,
        _contentDataKredit = contentDataKredit,
        assert(contentDataDebit != null && contentDataKredit != null);
  final List<V_detail_transaksi> _contentDataDebit;
  final List<V_detail_transaksi> _contentDataKredit;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _contentDataDebit.length) {
      return null;
    }

    int totalDebit = _contentDataDebit.length;
    int totalKredit = _contentDataKredit.length;

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 7 - 50,
          child: Column(
            children: [
              for (int i = 0; i < totalDebit; i++)
                Text("${_contentDataDebit[i].akun}")
            ],
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 50,
          child: Column(
            children: [
              for (int i = 0; i < totalDebit; i++)
                Text("Rp${_contentDataDebit[i].saldo}")
            ],
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 7 - 50,
          child: Column(
            children: [
              for (int i = 0; i < totalKredit; i++)
                Text("${_contentDataKredit[i].akun}")
            ],
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width / 3 - 50,
          child: Column(
            children: [
              for (int i = 0; i < totalKredit; i++)
                Text("Rp${_contentDataKredit[i].saldo}")
            ],
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _contentDataDebit.length;
  int get rowCount2 => _contentDataKredit.length;

  @override
  int get selectedRowCount => 0;
}
