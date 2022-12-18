import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_akun.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_pendapatan.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:sistem_akuntansi/ui/components/button.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/dialog.dart';
import 'package:sistem_akuntansi/model/response/amortisasi_aset.dart';
import 'package:sistem_akuntansi/utils/currency_format.dart';

class BukuBesarTableData extends DataTableSource {
  BuildContext context;
  BukuBesarTableData(
      {required List<VJurnalExpand> contentData, required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<VJurnalExpand> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('dd/MM').format(_content.tgl_transaksi),
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.nama_transaksi}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.no_bukti}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.jenis_transaksi}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${CurrencyFormat.convertToCurrency(_content.nominal_transaksi)}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
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

class BulanTahunTableData extends DataTableSource {
  Function(int) seeDetail;
  BuildContext context;
  BulanTahunTableData(
      {required List<VBulanJurnal> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<VBulanJurnal> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.bulan}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.tahun}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 0),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                seeDetail(index);
              },
              child: const Text(
                "Lihat Detail",
                style: TextStyle(
                  fontFamily: "Inter",
                  color: Color.fromARGB(255, 50, 52, 55),
                ),
              ),
            ),
          )
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

class RowTableCOA extends DataTableSource {
  Function(int) seeDetail;
  BuildContext context;
  RowTableCOA(
      {required List<Akun> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<Akun> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
            ),
        )
        ),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.kode_akun}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          )
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.nama_akun}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.keterangan_akun.replaceAll("_", ",")}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.indentasi}",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 204, 0),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    seeDetail(index);
                  },
                  child: const Text(
                    "Lihat Detail",
                    style: TextStyle(
                        fontFamily: "Inter",
                        color: Color.fromARGB(255, 50, 52, 55),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          )
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
      {required List<VJurnalExpand> contentDataDebit,
      required List<VJurnalExpand> contentDataKredit,
      required this.context})
      : _contentDataDebit = contentDataDebit,
        _contentDataKredit = contentDataKredit,
        assert(contentDataDebit != null && contentDataKredit != null);
  final List<VJurnalExpand> _contentDataDebit;
  final List<VJurnalExpand> _contentDataKredit;

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
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < totalDebit; i++)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text("${_contentDataDebit[i].nama_akun}")
                    ],
                  )
              ],
            ),
          )
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < totalDebit; i++)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text("${CurrencyFormat.convertToCurrency(_contentDataDebit[i].nominal_transaksi)}")
                    ],
                  ),
              ],
            ),
          )
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < totalKredit; i++)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text("${_contentDataKredit[i].nama_akun}")
                    ],
                  ),
              ],
            ),
          )
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (int i = 0; i < totalKredit; i++)
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Text("${CurrencyFormat.convertToCurrency(_contentDataKredit[i].nominal_transaksi)}"),
                    ],
                  ),
              ],
            ),
          )
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

class AmortisasiPendapatanTable extends DataTableSource {
  Function(int) seeDetail;
  BuildContext context;
  AmortisasiPendapatanTable(
      {required List<AmortisasiPendapatan> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<AmortisasiPendapatan> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.keterangan}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${CurrencyFormat.convertToCurrency(_content.jumlah)}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.jumlah_mhs}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${CurrencyFormat.convertToCurrency(_content.penyusutan)}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 255, 204, 0),
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                seeDetail(index);
              },
              child: const Text(
                "Lihat Detail",
                style: TextStyle(
                    fontFamily: "Inter",
                    color: Color.fromARGB(255, 50, 52, 55),
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
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

class AmortisasiAsetTable extends DataTableSource {
  Function(int) seeDetail;
  BuildContext context;
  AmortisasiAsetTable(
      {required List<AmortisasiAset> contentData,
      required this.seeDetail,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<AmortisasiAset> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.keterangan}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.tahun}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.masa_guna}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${CurrencyFormat.convertToCurrency(_content.nilai_awal)}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              margin: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${CurrencyFormat.convertToCurrency(_content.penyusutan)}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 204, 0),
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  seeDetail(index);
                },
                child: const Text(
                  "Lihat Detail",
                  style: TextStyle(
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 50, 52, 55),
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
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

class ListAmortisasiTable extends DataTableSource {
  Function onPressed1;
  Function(int) onPressed2;
  BuildContext context;
  ListAmortisasiTable(
      {required List<AmortisasiAkun> contentData,
      required this.onPressed1,
      required this.onPressed2,
      required this.context})
      : _contentData = contentData,
        assert(contentData != null);
  final List<AmortisasiAkun> _contentData;

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
          width: double.infinity,
          child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index+1}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${_content.nama_akun}",
                    style: TextStyle(
                      fontFamily: "Inter",
                    ),
                  ),
                ],
              )
          ),
        )),
        DataCell(SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kuning,
                padding: EdgeInsets.all(20),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog2Button(
                        content: "Hapus Transaksi",
                        content_detail: "Anda yakin ingin menghapus data ini?",
                        path_image: 'assets/images/hapus_coa.png',
                        button1: "Tetap Simpan",
                        button2: "Ya, Hapus",
                        onPressed1: () {
                          onPressed1();
                        },
                        onPressed2: () {
                          onPressed2(index);
                        },
                      );
                    });
              },
              child: Text("Hapus",
                  style: TextStyle(
                      fontFamily: "Inter",
                      color: hitam,
                      fontWeight: FontWeight.bold)),
            ),
          )
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
