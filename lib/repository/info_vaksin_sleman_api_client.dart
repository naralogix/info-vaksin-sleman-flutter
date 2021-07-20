import 'dart:convert';

import 'package:info_vaksin_sleman/models/faskes.dart';
import 'package:info_vaksin_sleman/repository/faskes_repository.dart';
import 'package:http/http.dart' as http;

class InfoVaksinSlemanApiClient implements FaskesRepository {
  InfoVaksinSlemanApiClient() {
    _httpClient = http.Client();
  }

  late http.Client _httpClient;

  static const String _baseUrl =
      'https://info-vaksin-sleman.vercel.app/api/v1/';

  @override
  Future<List<Faskes>> fetchAllFaskesWithVaccinationSchedules() async {
    final Map<String, dynamic> jsonResponse = await _sendRequest('jadwal');

    final List<Map<String, dynamic>> data =
        List<Map<String, dynamic>>.from(jsonResponse['data'] as List<dynamic>);

    return data
        .map((Map<String, dynamic> json) => Faskes.fromJson(json))
        .toList();
  }

  Future<Map<String, dynamic>> _sendRequest(String tag) async {
    final String url = '$_baseUrl$tag';
    final http.Response response = await _httpClient.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody =
          json.decode(response.body) as Map<String, dynamic>;
      return jsonBody;
    } else {
      throw Exception('Failed to get data from server');
    }
  }
}
