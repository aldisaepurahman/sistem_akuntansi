class V_detail_transaksi {
  String akun;
  String saldo;

  V_detail_transaksi({required this.akun, required this.saldo});
}

List<V_detail_transaksi> contents_debit = [
  V_detail_transaksi(
    akun: 'Beban Pemeliharaan RT dan Lingkungan',
    saldo: '200.000',
  ),
  V_detail_transaksi(
    akun: 'Beban Rekening PDAM',
    saldo: '200.000',
  ),
  V_detail_transaksi(
    akun: 'Beban Rekening PDAM S1 Keperawatan',
    saldo: '100.000',
  ),
];

List<V_detail_transaksi> contents_kredit = [
  V_detail_transaksi(
    akun: 'Rekening Giro Bank NISP',
    saldo: '500.000',
  )
];
