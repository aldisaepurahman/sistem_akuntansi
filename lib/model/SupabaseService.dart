import 'package:sistem_akuntansi/bloc/bloc_constants.dart';
import 'package:sistem_akuntansi/model/response/akun.dart';
import 'package:sistem_akuntansi/model/response/jenis_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vbulan_jurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal.dart';
import 'package:sistem_akuntansi/model/response/vjurnal_expand.dart';
import 'package:sistem_akuntansi/model/response/vlookup.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  const SupabaseService({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<ServiceStatus> getAllCOA(
      String table_name, Map<String, String> keyword) async {
    try {
      final response = (keyword.isEmpty)
          ? await _supabaseClient.from(table_name).select()
          : await _supabaseClient
              .from(table_name)
              .select()
              .like(keyword.keys.first, "%${keyword.values.first}%");

      if (response == null) {
        return ServiceStatus(
            datastore: List<Akun>.from([]), message: response.toString());
      }

      return ServiceStatus(
          datastore:
              List<Akun>.from(response.map((e) => Akun.fromJson(e)).toList()));
    } on PostgrestException catch (error) {
      return ServiceStatus(
          datastore: List<Akun>.from([]), message: error.message);
    } on NoSuchMethodError catch (error) {
      return ServiceStatus(
          datastore: List<Akun>.from([]), message: error.stackTrace.toString());
    }
  }

  Future<ServiceStatus> getDetailCOA(
      String table_name, Map<String, String> keyword) async {
    Map<int, String> listbulan = {
      1: "Januari",
      2: "Februari",
      3: "Maret",
      4: "April",
      5: "Mei",
      6: "Juni",
      7: "Juli",
      8: "Agustus",
      9: "September",
      10: "Oktober",
      11: "November",
      12: "Desember"
    };

    try {
      final response = await _supabaseClient
          .from(table_name)
          .select()
          .eq(keyword.keys.first, keyword.values.first)
          .eq("bulan", listbulan[DateTime.now().month])
          .eq("tahun", DateTime.now().year)
          .single();

      if (response == null) {
        return ServiceStatus(
            datastore: const VLookup(), message: response.toString());
      }

      return ServiceStatus(datastore: VLookup.fromJson(response));
    } on PostgrestException catch (error) {
      return ServiceStatus(datastore: const VLookup());
    } on NoSuchMethodError catch (error) {
      return ServiceStatus(
          datastore: const VLookup(), message: error.stackTrace.toString());
    }
  }

  Future<ServiceStatus> getAllTransaksiJurnal(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      final response = (equivalent['id_jurnal'] > 0)
          ? await _supabaseClient
              .from(table_name)
              .select()
              .eq("month", equivalent['bulan'])
              .eq("year", equivalent['tahun'])
              .eq("id_jurnal", equivalent['id_jurnal'])
          : await _supabaseClient
              .from(table_name)
              .select()
              .eq("month", equivalent['bulan'])
              .eq("year", equivalent['tahun']);

      if (response == null) {
        return ServiceStatus(
            datastore: List<VJurnalExpand>.from([]), message: response.toString());
      }

      var data = List<Map<String, dynamic>>.from(response);

      return ServiceStatus(datastore: List<VJurnalExpand>.from(response.map((e) => VJurnalExpand.fromJson(e)).toList()));
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<ServiceStatus> getAllBulan(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      final response = (equivalent['month'] > 0 && equivalent['year'] > 0)
          ? await _supabaseClient
              .from(table_name)
              .select()
              .eq("month", equivalent['month'])
              .eq("year", equivalent['year'])
          : (equivalent['month'] > 0)
              ? await _supabaseClient
                  .from(table_name)
                  .select()
                  .eq("month", equivalent['month'])
              : (equivalent['year'] > 0)
                  ? await _supabaseClient
                      .from(table_name)
                      .select()
                      .eq("year", equivalent['year'])
                  : await _supabaseClient.from(table_name).select();

      if (response == null) {
        return ServiceStatus(
            datastore: List<VBulanJurnal>.from([]),
            message: response.toString());
      }

      return ServiceStatus(
          datastore: List<VBulanJurnal>.from(
              response.map((e) => VBulanJurnal.fromJson(e)).toList()));
    } catch (error, stackTrace) {
      return ServiceStatus(
          datastore: List<VBulanJurnal>.from([]),
          message: stackTrace.toString());
    }
  }

  Future<ServiceStatus> getAllJurnal(
      String table_name, Map<String, dynamic> equivalent) async {
    try {
      final response = await _supabaseClient
          .from(table_name)
          .select()
          .eq("tipe_jurnal", equivalent['tipe_jurnal']);

      if (response == null) {
        return ServiceStatus(
            datastore: List<JenisJurnalModel>.from([]),
            message: response.toString());
      }

      return ServiceStatus(
          datastore: List<JenisJurnalModel>.from(
              response.map((e) => JenisJurnalModel.fromJson(e)).toList()));
    } catch (error, stackTrace) {
      return ServiceStatus(
          datastore: List<JenisJurnalModel>.from([]),
          message: stackTrace.toString());
    }
  }

  Future<void> insert(
      String table_name, Map<String, dynamic> data_insert) async {
    try {
      await _supabaseClient.from(table_name).insert(data_insert);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> multiple_insert(
      String table_name, List<Map<String, dynamic>> data_insert) async {
    try {
      await _supabaseClient.from(table_name).insert(data_insert);
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
          .eq(equivalent.keys.first, equivalent.values.first);
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
