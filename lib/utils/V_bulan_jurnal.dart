class V_bulan_jurnal {
  String bulan;
  String tahun;

  V_bulan_jurnal({required this.bulan, required this.tahun});
}

List<V_bulan_jurnal> contents = [
  V_bulan_jurnal(
    bulan: 'November',
    tahun: '2022',
  ),
  V_bulan_jurnal(
    bulan: 'Desember',
    tahun: '2022',
  ),
  V_bulan_jurnal(
    bulan: 'Januari',
    tahun: '2023',
  ),
];