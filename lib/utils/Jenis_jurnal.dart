class Jenis_jurnal {
  String nama_jurnal;

  Jenis_jurnal({
    required this.nama_jurnal,
  });
}

List<Jenis_jurnal> contents = [
  Jenis_jurnal(
    nama_jurnal: 'JURNAL PENGELUARAN KAS',
  ),
  Jenis_jurnal(
    nama_jurnal: 'JURNAL PENERIMAAN KAS',
  ),
  Jenis_jurnal(
    nama_jurnal: 'PENGELUARAN BANK OCBC NISP',
  ),
  Jenis_jurnal(
    nama_jurnal: 'PENERIMAAN BANK OCBC NISP',
  ),
  Jenis_jurnal(
    nama_jurnal: 'PENGELUARAN BRI STIKES SANTO BORROMEUS',
  ),
  Jenis_jurnal(
    nama_jurnal: 'PENERIMAAN BRI STIKES SANTO BORROMEUS',
  ),
];