import 'package:info_vaksin_sleman/models/vac_schedule.dart';

class Faskes {
  Faskes({
    required this.nama,
    required this.wilayah,
    this.lat,
    this.lon,
    this.daftarJadwalVaksin,
  });

  factory Faskes.fromJson(Map<String, dynamic> json) {
    List<VacSchedule>? daftarJadwalVaksin;
    final List<dynamic> jadwalInJson = json['jadwal'] as List<dynamic>;
    if (jadwalInJson.isNotEmpty) {
      daftarJadwalVaksin = jadwalInJson
          .map((dynamic e) => e as Map<String, dynamic>)
          .toList()
          .map((Map<String, dynamic> e) => VacSchedule.fromJson(e))
          .toList();
    }

    return Faskes(
      nama: json['nama'] as String,
      wilayah: json['wilayah'] as String,
      lat: json.containsKey('lat') ? json['lat'] as double : null,
      lon: json.containsKey('lon') ? json['lon'] as double : null,
      daftarJadwalVaksin: daftarJadwalVaksin,
    );
  }

  final String nama;
  final String wilayah;
  final double? lat;
  final double? lon;
  final List<VacSchedule>? daftarJadwalVaksin;

  bool get hasEmptySlot {
    if (daftarJadwalVaksin == null) {
      return false;
    } else {
      for (final VacSchedule jadwalVaksin in daftarJadwalVaksin!) {
        if (jadwalVaksin.quota > 0 && jadwalVaksin.sisa > 0) {
          return true;
        }
      }
      return false;
    }
  }
}
