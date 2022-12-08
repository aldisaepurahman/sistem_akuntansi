import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  const SupabaseService({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<VLookup>> getAllCOA(
      String table_name, Map<String, String> keyword) async {
    try {
      final response = (keyword.isEmpty)
          ? await _supabaseClient.from(table_name).select()
          : await _supabaseClient
              .from(table_name)
              .select()
              .like(keyword.keys.first, keyword.values.first);

      final data = response.data as List<Map<String, dynamic>>;
      return data.map((e) => VLookup.fromJson(e)).toList();
    } on PostgrestException catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<VJurnal>> getAllJurnal(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      final response = (equivalent['id_jurnal'] > 0)
          ? await _supabaseClient
              .from(table_name)
              .select()
              .eq("EXTRACT(MONTH FROM tgl_transaksi)", equivalent['bulan'])
              .eq("EXTRACT(YEAR FROM tgl_transaksi)", equivalent['tahun'])
              .eq("id_jurnal", equivalent['id_jurnal'])
              .execute()
          : await _supabaseClient
              .from(table_name)
              .select()
              .eq("EXTRACT(MONTH FROM tgl_transaksi)", equivalent['bulan'])
              .eq("EXTRACT(YEAR FROM tgl_transaksi)", equivalent['tahun'])
              .execute();

      final data = response.data as List<Map<String, dynamic>>;
      // return data.map((e) => VJurnal.fromJson(e)).toList();
      return data
          .fold(
              {},
              (a, b) => {
                    ...a,
                    b['id_transaksi']: [b, ...?a[b['id_transaksi']]],
                  })
          .values
          .where((l) => l.isNotEmpty)
          .map((l) => VJurnal(
              id_transaksi: l.first['id_transaksi'],
              id_jurnal: l.first['id_jurnal'],
              id_jenis_jurnal: l.first['id_jenis_jurnal'],
              tgl_transaksi: l.first['tgl_transaksi'],
              nama_transaksi: l.first['nama_transaksi'],
              no_bukti: l.first['no_bukti'],
              detail_transaksi: l
                  .map((e) => {
                        'id_transaksi_dk': e['id_transaksi_dk'],
                        'kode_akun': e['kode_akun'],
                        'jenis_transaksi': e['jenis_transaksi'],
                        'nominal_transaksi': e['nominal_transaksi']
                      })
                  .toList()))
          .toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<List<VBulanJurnal>> getAllBulan(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      final response = (equivalent['bulan'] > 0 && equivalent['tahun'] > 0)
          ? await _supabaseClient
              .from(table_name)
              .select()
              .eq("EXTRACT(MONTH FROM tgl_transaksi)", equivalent['bulan'])
              .eq("EXTRACT(YEAR FROM tgl_transaksi)", equivalent['tahun'])
              .eq("id_jurnal", equivalent['id_jurnal'])
              .execute()
          : (equivalent['bulan'] > 0)
              ? await _supabaseClient
                  .from(table_name)
                  .select()
                  .eq("EXTRACT(MONTH FROM tgl_transaksi)", equivalent['bulan'])
                  .execute()
              : (equivalent['tahun'] > 0)
                  ? await _supabaseClient
                      .from(table_name)
                      .select()
                      .eq("EXTRACT(YEAR FROM tgl_transaksi)",
                          equivalent['tahun'])
                      .execute()
                  : await _supabaseClient.from(table_name).select().execute();

      final data = response.data as List<Map<String, dynamic>>;
      return data.map((e) => VBulanJurnal.fromJson(e)).toList();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> insert(
      String table_name, Map<String, dynamic> data_insert) async {
    try {
      await _supabaseClient.from(table_name).insert(data_insert).execute();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> update(String table_name, Map<String, dynamic> data_update,
      Map<String, dynamic> equivalent) async {
    try {
      await _supabaseClient
          .from(table_name)
          .update(data_update)
          .eq(equivalent.keys.first, equivalent.values.first)
          .execute();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> delete(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      await _supabaseClient
          .from(table_name)
          .delete()
          .eq(equivalent.keys.first, equivalent.values.first)
          .execute();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

/*addData() async{

  }

  readData() async{

  }

  updateData() async{

  }

  deleteData() async{

  }*/
}
