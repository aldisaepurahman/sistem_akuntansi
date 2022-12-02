import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';

import 'akun/akun.dart';

class SupabaseService {

  const SupabaseService({required SupabaseClient supabaseClient}) : _supabaseClient = supabaseClient;

  final SupabaseClient _supabaseClient;

  Future<List<Akun>> getAllCOA() async {
    try {
      final response = await _supabaseClient
          .from('CoA')
          .select()
          .execute();

      final data = response.data as List<Map<String, dynamic>>;
      return data.map((e) => Akun.fromJson(e)).toList();
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