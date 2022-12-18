import 'dart:math';

import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import "package:collection/collection.dart";

enum TableViewType {
  pengguna,
  coa,
  coa_saldo,
  jurnal_umum,
  transaksi_utama,
  transaksi_akun,
  jurnal,
  list_coa_saldo,
  v_pendapatan_beban_lookup,
  v_jurnal,
  v_bulan_jurnal,
  v_saldo_jurnal_umum,
  v_total_saldo_akun_jurnal_umum,
  v_saldo_jurnal_penyesuaian,
  v_neraca_lajur,
  amortisasi_akun,
  amortisasi_aset,
  amortisasi_aset_detail,
  amortisasi_pendapatan,
  amortisasi_pendapatan_detail,
  stibo_users
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Map<String, List<VJurnalExpand>> mappings(List<VJurnalExpand> journal) {
  return groupBy(journal, (VJurnalExpand obj) => "${obj.id_transaksi}+${obj.nama_transaksi}+${obj.tgl_transaksi}+${obj.id_jurnal}+${obj.no_bukti}+${obj.nama_jurnal}");
}

List<VJurnal> encodeToTransaction(List<VJurnalExpand> journal) {
  var dataset = List<Map<String, dynamic>>.from(journal.map((e) => e.toJson()).toList());
  return dataset.fold(
      {},
          (a, b) => {
        ...a,
        b['id_transaksi']: [b, ...?a[b['id_transaksi']]],
      })
      .values
      .map((l) => VJurnal(
      id_transaksi: l.first['id_transaksi'],
      id_jurnal: l.first['id_jurnal'],
      tgl_transaksi: DateTime.parse(l.first['tgl_transaksi']),
      nama_transaksi: l.first['nama_transaksi'],
      no_bukti: l.first['no_bukti'],
      detail_transaksi: l
          .map((e) => {
        'id_transaksi_akun': e['id_transaksi_akun'],
        'coa_kode_akun': e['coa_kode_akun'],
        'nama_akun': e['nama_akun'],
        'jenis_transaksi': e['jenis_transaksi'],
        'nominal_transaksi': e['nominal_transaksi']
      })
          .toList()))
      .toList();
}