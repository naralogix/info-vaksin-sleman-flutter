import 'package:info_vaksin_sleman/models/faskes.dart';

abstract class FaskesRepository {
  Future<List<Faskes>> fetchAllFaskesWithVaccinationSchedules();
}
