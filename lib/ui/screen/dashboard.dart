import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sistem_akuntansi/bloc/SiakState.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_bloc.dart';
import 'package:sistem_akuntansi/bloc/vjurnal/vjurnal_event.dart';
import 'package:sistem_akuntansi/model/SupabaseService.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/ui/components/color.dart';
import 'package:sistem_akuntansi/ui/components/card.dart';
import 'package:sistem_akuntansi/ui/components/table.dart';
import 'package:supabase/supabase.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({required this.client, super.key});

  final SupabaseClient client;

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  late VJurnalBloc _jurnalBloc;
  var list_transaksi = <VJurnalExpand>[];
  var temp_transaksi = <VJurnalExpand>[];
  var total_saldo = 0;
  var total_saldo_debit = 0;
  var total_saldo_kredit = 0;

  @override
  void initState() {
    super.initState();
    _jurnalBloc = VJurnalBloc(service: SupabaseService(supabaseClient: widget.client))..add(JurnalFetched(bulan: DateTime.now().month, tahun: DateTime.now().year));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _jurnalBloc,
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Berikut catatan pemasukan dan pengeluaran keuangan untuk periode ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: greyFontColor,
                    fontFamily: "Inter",
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                BlocConsumer<VJurnalBloc, SiakState>(
                  builder: (_, state) {
                    if (state is LoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is FailureState) {
                      return Center(child: Text(state.error));
                    }
                    if (state is SuccessState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Row(
                              children: [
                                CardSaldo(
                                  total: "${temp_transaksi.length}",
                                  fontColor: textColor,
                                  bgColor: yellowTextColor,
                                  textCard: "Total Transaksi",
                                  imgPath: "assets/icons/EmptyWallet.svg",
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CardSaldo(
                                  total: "+ Rp " + "$total_saldo_kredit",
                                  fontColor: greenColor,
                                  bgColor: whiteColor,
                                  textCard: "Total Pemasukan",
                                  imgPath: "assets/icons/CardReceive.svg",
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CardSaldo(
                                  total: "- Rp " + "$total_saldo_debit",
                                  fontColor: redColor,
                                  bgColor: whiteColor,
                                  textCard: "Total Pengeluaran",
                                  imgPath: "assets/icons/CardSend.svg",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Riwayat Transaksi",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: textColor,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                for (var trans in list_transaksi)
                                  TableDashboard(
                                    tanggal: DateFormat('dd/MM').format(trans.tgl_transaksi),
                                    nama_transaksi: trans.nama_transaksi,
                                    keterangan: trans.jenis_transaksi,
                                    saldo: trans.nominal_transaksi,
                                  ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const Center(child: Text("No Data"));
                  },
                  listener: (_, state) {
                    if (state is SuccessState) {
                      temp_transaksi.clear();
                      list_transaksi.clear();

                      temp_transaksi = state.datastore;
                      temp_transaksi.sort((b, a) => a.id_transaksi.compareTo(b.id_transaksi));

                      for(var i = 0; i < 5; i += 1) {
                        list_transaksi.add(temp_transaksi[i]);
                      }

                      for(var trans in temp_transaksi) {
                        if (trans.jenis_transaksi.contains("Debit")) {
                          total_saldo -= trans.nominal_transaksi;
                          total_saldo_debit += trans.nominal_transaksi;
                        } else {
                          total_saldo += trans.nominal_transaksi;
                          total_saldo_kredit += trans.nominal_transaksi;
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}