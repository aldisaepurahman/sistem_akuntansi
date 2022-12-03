import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/tableRow.dart';
import 'package:sistem_akuntansi/ui/components/navigationBar.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';
import 'package:sistem_akuntansi/utils/V_bulan_jurnal.dart';

class ListBukuBesar extends StatefulWidget {
  const ListBukuBesar({Key? key}) : super(key: key);

  @override
  ListBukuBesarState createState() {
    return ListBukuBesarState();
  }
}

class ListBukuBesarState extends State<ListBukuBesar> {
  // @override
  // void dispose() {}

  String _selectedMonthValue = 'Bulan';
  String _selectedYearValue = 'Tahun';

  List<String> month = ['Bulan', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
  List<String> year = ['Tahun', '2022'];

  var tableRow;

  @override
  void initState() {
    super.initState();
    tableRow = new TableRow(
      contentData: contents,
      seeDetail: (){
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SideNavigationBar(index: 1, coaIndex: 2)));
        });
      },
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Buku Besar',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Buku Besar",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Color.fromARGB(255, 50, 52, 55)),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SideNavigationBar(index: 1, coaIndex: 1)));
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    size: 13,
                                    color:
                                    Color.fromARGB(255, 50, 52, 55),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Tambah Buku Besar",
                                    style: TextStyle(
                                      fontFamily: "Inter",
                                      color: Color.fromARGB(255, 50, 52, 55),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          DropdownForm(
                            onChanged: (String? newValue){
                              setState(() {
                                if (newValue != null) {
                                  _selectedMonthValue = newValue;
                                }
                              });
                            },
                            content: _selectedMonthValue,
                            item: month,
                          ),
                          SizedBox(width: 20),
                          DropdownForm(
                            onChanged: (String? newValue){
                              setState(() {
                                if (newValue != null) {
                                  _selectedYearValue = newValue;
                                }
                              });
                            },
                            content: _selectedYearValue,
                            item: year,
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      PaginatedDataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text("No."),),
                          DataColumn(label: Text("Bulan"),),
                          DataColumn(label: Text("Tahun"),),
                          DataColumn(label: Text("Action"),),
                        ],
                        source: tableRow,
                        rowsPerPage: 5,
                        showCheckboxColumn: false,
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}

class TableRow extends DataTableSource {
  Function seeDetail;
  BuildContext context;
  TableRow({required List<V_bulan_jurnal> contentData, required this.seeDetail, required this.context}) : _contentData = contentData, assert(contentData != null);
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
