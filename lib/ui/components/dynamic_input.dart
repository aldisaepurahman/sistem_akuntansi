import 'package:flutter/material.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/form.dart';

class DynamicDebitWidget extends StatefulWidget {
  final List<String> namaAkunList;
  final int formCase;

  final TextEditingController akunDebitText = TextEditingController();
  final TextEditingController jumlahDebitText = TextEditingController();

  final TextEditingController akunDebitUpdateText = TextEditingController();
  final TextEditingController jumlahDebitUpdateText = TextEditingController();

  DynamicDebitWidget({
    required this.namaAkunList,
    required this.formCase,
  });

  @override
  DynamicDebitWidgetState createState() => DynamicDebitWidgetState();
}

class DynamicDebitWidgetState extends State<DynamicDebitWidget> {

  @override
  void dispose() {
    widget.akunDebitText.dispose();
    widget.jumlahDebitText.dispose();
    widget.akunDebitUpdateText.dispose();
    widget.jumlahDebitUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox( // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: abu_transparan
                  )
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DropdownSearchButton(
                  isNeedChangeColor: false,
                  notFoundText: 'Akun tidak ditemukan',
                  hintText: 'Pilih akun',
                  controller: (widget.formCase == 1 ? widget.akunDebitText : widget.akunDebitUpdateText),
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        if (widget.formCase == 1) {
                          widget.akunDebitText.text = newValue;
                        }
                        else {
                          widget.akunDebitUpdateText.text = newValue;
                        }
                      }
                    });
                  },
                  items: widget.namaAkunList,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: (widget.formCase == 1 ? widget.jumlahDebitText : widget.jumlahDebitUpdateText),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}

class DynamicKreditWidget extends StatefulWidget {
  final List<String> namaAkunList;
  final int formCase;

  final TextEditingController akunKreditText = TextEditingController();
  final TextEditingController jumlahKreditText = TextEditingController();

  final TextEditingController akunKreditUpdateText = TextEditingController();
  final TextEditingController jumlahKreditUpdateText = TextEditingController();

  DynamicKreditWidget({
    required this.namaAkunList,
    required this.formCase,
  });

  @override
  DynamicKreditWidgetState createState() => DynamicKreditWidgetState();
}

class DynamicKreditWidgetState extends State<DynamicKreditWidget> {
  @override
  void dispose() {
    widget.akunKreditText.dispose();
    widget.jumlahKreditText.dispose();
    widget.akunKreditUpdateText.dispose();
    widget.jumlahKreditUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox( // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DropdownSearchButton(
                  isNeedChangeColor: false,
                  notFoundText: 'Akun tidak ditemukan',
                  hintText: 'Pilih akun',
                  controller: (widget.formCase == 1 ? widget.akunKreditText : widget.akunKreditUpdateText),
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        if (widget.formCase == 1) {
                          widget.akunKreditText.text = newValue;
                        }
                        else {
                          widget.akunKreditUpdateText.text = newValue;
                        }
                      }
                    });
                  },
                  items: widget.namaAkunList,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: (widget.formCase == 1 ? widget.jumlahKreditText : widget.jumlahKreditUpdateText),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}

class DynamicDebitInsertWidget extends StatefulWidget {
  final List<String> namaAkunList;

  final TextEditingController akunDebitText = TextEditingController();
  final TextEditingController jumlahDebitText = TextEditingController();

  final TextEditingController akunDebitUpdateText = TextEditingController();
  final TextEditingController jumlahDebitUpdateText = TextEditingController();

  DynamicDebitInsertWidget({
    required this.namaAkunList,
  });

  @override
  DynamicDebitInsertWidgetState createState() => DynamicDebitInsertWidgetState();
}

class DynamicDebitInsertWidgetState extends State<DynamicDebitInsertWidget> {
  @override
  void dispose() {
    widget.akunDebitText.dispose();
    widget.jumlahDebitText.dispose();
    widget.akunDebitUpdateText.dispose();
    widget.jumlahDebitUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox( // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(
                      color: abu_transparan
                  )
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DropdownSearchButton(
                  isNeedChangeColor: false,
                  notFoundText: 'Akun tidak ditemukan',
                  hintText: 'Pilih akun',
                  controller: widget.akunDebitText,
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        widget.akunDebitText.text = newValue;
                      }
                    });
                  },
                  items: widget.namaAkunList,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: widget.jumlahDebitText,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}

class DynamicKreditInsertWidget extends StatefulWidget {
  final List<String> namaAkunList;

  final TextEditingController akunKreditText = TextEditingController();
  final TextEditingController jumlahKreditText = TextEditingController();

  final TextEditingController akunKreditUpdateText = TextEditingController();
  final TextEditingController jumlahKreditUpdateText = TextEditingController();

  DynamicKreditInsertWidget({
    required this.namaAkunList,
  });

  @override
  DynamicKreditInsertWidgetState createState() => DynamicKreditInsertWidgetState();
}

class DynamicKreditInsertWidgetState extends State<DynamicKreditInsertWidget> {
  @override
  void dispose() {
    widget.akunKreditText.dispose();
    widget.jumlahKreditText.dispose();
    widget.akunKreditUpdateText.dispose();
    widget.jumlahKreditUpdateText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox( // BAGIAN DEBIT
      width: MediaQuery.of(context).size.width * 0.40,
      child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: DropdownSearchButton(
                  isNeedChangeColor: false,
                  notFoundText: 'Akun tidak ditemukan',
                  hintText: 'Pilih akun',
                  controller: widget.akunKreditText,
                  onChange: (String? newValue){
                    setState(() {
                      if(newValue != null) {
                        widget.akunKreditText.text = newValue;
                      }
                    });
                  },
                  items: widget.namaAkunList,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextForm(
                  hintText: "Jumlah",
                  textController: widget.jumlahKreditText,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
      ),
    );
  }
}