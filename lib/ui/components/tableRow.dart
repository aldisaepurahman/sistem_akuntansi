import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';

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

class RowTable extends DataTableSource {
  Function seeDetail;
  BuildContext context;
  RowTable(
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
