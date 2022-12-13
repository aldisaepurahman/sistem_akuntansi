import 'package:sistem_akuntansi/bloc/Event.dart';
import 'package:sistem_akuntansi/model/response/transaksi_debit_kredit.dart';
import 'package:sistem_akuntansi/model/response/transaksi_model.dart';

class TransaksiInserted extends Event {
  final TransaksiModel transaksiModel;
  final List<TransaksiDK> transaksi_dk;

  TransaksiInserted({required this.transaksiModel, required this.transaksi_dk});
}