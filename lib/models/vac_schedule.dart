class VacSchedule {
  VacSchedule({
    required this.quota,
    required this.tanggalVaksin,
    required this.sisa,
  });

  factory VacSchedule.fromJson(Map<String, dynamic> json) => VacSchedule(
        quota: json['quota'] as int,
        tanggalVaksin: json['tanggal_vaksin'] as String,
        sisa: json['sisa'] as int,
      );

  final int quota;
  final String tanggalVaksin;
  final int sisa;
}
