import 'package:flutter/material.dart';

class InsertCOA extends StatefulWidget {
  const InsertCOA({Key? key}) : super(key: key);

  @override
  InsertCOAState createState() {
    return InsertCOAState();
  }
}

class InsertCOAState extends State<InsertCOA> {
  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Tambah Chart of Account',
        home: Scaffold(
            backgroundColor: Color.fromARGB(255, 248, 249, 253),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 25, bottom: 15, left: 25),
                  child: const Text(
                    "Tambah Chart of Account",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Color.fromARGB(255, 50, 52, 55)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  padding: EdgeInsets.all(25),
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: const Text(
                        "Informasi CoA",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 255, 204, 0)),
                      )),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Nama Akun",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Masukkan nama akun...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan kode...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Keterangan',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan keterangan...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kode Reference',
                                  style: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 50, 52, 55))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Masukkan kode...',
                                        contentPadding: const EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8))),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text(
                          "Saldo Awal (Opsional)",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              color: Color.fromARGB(255, 50, 52, 55)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: 'Rp',
                              hintText: 'Masukkan saldo awal...',
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16, bottom: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 204, 0),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            setState(() {});
                          },
                          child: const Text(
                            "Simpan",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Color.fromARGB(255, 50, 52, 55),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(20)),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text(
                            "Batalkan",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: Color.fromARGB(255, 245, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
