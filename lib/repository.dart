import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class Repository {
  final _baseUrl = 'https://649871a09543ce0f49e20a66.mockapi.io';

  Future<List<Hospital>> getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/hospital'));

      if (response.statusCode == 200) {
        Iterable<dynamic> it = jsonDecode(response.body);
        List<Hospital> hospital = it.map((e) => Hospital.fromJson(e)).toList();
        return hospital;
      } else {
        throw Exception('Gagal memuat data dari API');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal terhubung ke API');
    }
  }

  Future<Hospital> getDataById(int id) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/hospital/$id'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        Hospital hospital = Hospital.fromJson(data);
        return hospital;
      } else {
        throw Exception('Gagal memuat data dari API');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal terhubung ke API');
    }
  }

  Future<bool> postData(String namaPegawai, String alamat) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/hospital'),
          body: {"nama_pegawai": namaPegawai, "alamat": alamat});

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal terhubung ke API');
    }
  }

  Future<bool> putData(int id, String namaPegawai, String alamat) async {
    try {
      final response = await http.put(Uri.parse(_baseUrl + '/hospital/$id'),
          body: {"nama_pegawai": namaPegawai, "alamat": alamat});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal terhubung ke API');
    }
  }

  Future<bool> deleteData(int id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + '/hospital/$id'));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Gagal terhubung ke API');
    }
  }
}
