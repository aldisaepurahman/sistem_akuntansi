import 'package:equatable/equatable.dart';

class VJurnalExpand extends Equatable {
  String id_transaksi;
  int id_transaksi_akun;
  int id_jurnal;
  String nama_jurnal;
  DateTime tgl_transaksi;
  String nama_transaksi;
  String no_bukti;
  String kode_akun;
  String nama_akun;
  int nominal_transaksi;
  String jenis_transaksi;

  VJurnalExpand(
      {this.id_transaksi = "",
        this.id_transaksi_akun = 0,
        this.id_jurnal = 0,
        this.nama_jurnal = "",
        required this.tgl_transaksi,
        this.nama_transaksi = "",
        this.no_bukti = "",
        this.kode_akun = "",
        this.nama_akun = "",
        this.nominal_transaksi = 0,
        this.jenis_transaksi = ""
      });

  factory VJurnalExpand.fromJson(Map<String, dynamic> json) {
    return VJurnalExpand(
      id_transaksi: json['id_transaksi'],
        id_transaksi_akun: json['id_transaksi_akun'],
        id_jurnal: json['id_jurnal'],
        nama_jurnal: json['kategori_jurnal'],
        tgl_transaksi: DateTime.parse(json['tgl_transaksi']),
      nama_transaksi: json['nama_transaksi'],
      no_bukti: json['no_bukti'],
      kode_akun: json['coa_kode_akun'],
      nama_akun: json['nama_akun'],
      nominal_transaksi: json['nominal_transaksi'],
      jenis_transaksi: json['jenis_transaksi']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id_transaksi": this.id_transaksi,
      "id_transaksi_akun": this.id_transaksi_akun,
      "id_jurnal": this.id_jurnal,
      "kategori_jurnal": this.nama_jurnal,
      "tgl_transaksi": this.tgl_transaksi.toIso8601String(),
      "nama_transaksi": this.nama_transaksi,
      "no_bukti": this.no_bukti,
      "coa_kode_akun": this.kode_akun,
      "nama_akun": this.nama_akun,
      "nominal_transaksi": this.nominal_transaksi,
      "jenis_transaksi": this.jenis_transaksi
    };
  }

  @override
  List<Object> get props => [
    id_transaksi,
    id_jurnal,
    nama_jurnal,
    tgl_transaksi,
    nama_transaksi,
    no_bukti,
    id_transaksi_akun,
    kode_akun,
    nominal_transaksi,
    jenis_transaksi
  ];
}