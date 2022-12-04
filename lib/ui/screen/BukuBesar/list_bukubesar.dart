import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/text_template.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
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

  String _selectedMonthFilter = 'Januari';
  String _selectedYearFilter = '2022';

  String _selectedMonthInsert = 'Januari';
  String _selectedYearInsert = '2022';

  List<String> month = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
  List<String> year = ['2022', '2023'];

  var tableRow;

  bool show = false;
  bool disable_button = false;

  void showForm() {
    setState(() {
      show = true;
      disable_button = true;
    });
  }

  void disableForm() {
    setState(() {
      show = false;
      disable_button = false;
    });
  }

  @override
  void initState() {
    super.initState();
    tableRow = new TableRow(
      contentData: contents,
      seeDetail: (){
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SideNavigationBar(index: 3, coaIndex: 0, bukuBesarIndex: 1)));
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
                // Container(
                //   margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ButtonBack(
                //         onPressed: (){
                //           setState(() {
                //             Navigator.pop(context);
                //           });
                //         },
                //       )
                //     ],
                //   )
                // ),
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
                      SizedBox(height: 25),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 255, 204, 0),
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: disable_button ? null : showForm,
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
                Visibility(
                  visible: show,
                  child: Container(
                    margin: EdgeInsets.all(25),
                    padding: EdgeInsets.all(25),
                    color: background2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: HeaderText(
                              content: "Tambah Buku Besar",
                              size: 18,
                              color: hitam),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width:
                                MediaQuery.of(context).size.width * 0.25,
                                child: DropdownForm(
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedMonthInsert = newValue!;
                                    });
                                  },
                                  content: _selectedMonthInsert,
                                  items: month,
                                  label: "--Pilih Bulan--"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.25,
                                  child: DropdownForm(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedYearInsert = newValue!;
                                      });
                                    },
                                    content: _selectedYearInsert,
                                    items: year,
                                    label: "--Pilih Tahun--")),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonNoIcon(
                              bg_color: background2,
                              text_color: merah,
                              onPressed: disableForm,
                              content: "Batal"),
                            SizedBox(width: 20),
                            ButtonNoIcon(
                              bg_color: kuning,
                              text_color: hitam,
                              onPressed: () {
                                setState(() {});
                              },
                              content: "Simpan"
                            )
                          ],
                        )
                      ],
                    ),
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
                          DropdownFilter(
                            onChanged: (String? newValue){
                              setState(() {
                                if (newValue != null) {
                                  _selectedMonthFilter = newValue;
                                }
                              });
                            },
                            content: _selectedMonthFilter,
                            items: month,
                          ),
                          SizedBox(width: 20),
                          DropdownFilter(
                            onChanged: (String? newValue){
                              setState(() {
                                if (newValue != null) {
                                  _selectedYearFilter = newValue;
                                }
                              });
                            },
                            content: _selectedYearFilter,
                            items: year,
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
