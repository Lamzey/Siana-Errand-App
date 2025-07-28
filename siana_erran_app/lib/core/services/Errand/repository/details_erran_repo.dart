
// Repository pattern for data management
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/features/Errands/constants/details_errand_contsants.dart' as ExampleErrandListScreen;

abstract class ErrandRepository {
  Future<List<ErrandModel>> getErrands();
  Future<ErrandModel> getErrandById(String id);
  Future<ErrandModel> updateErrand(ErrandModel errand);
  Future<void> cancelErrand(String id);
  Future<ErrandModel> createErrand(ErrandModel errand);
}

class ErrandRepositoryImpl implements ErrandRepository {
  // This would typically connect to your API or local database

  @override
  Future<List<ErrandModel>> getErrands() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    return ExampleErrandListScreen.sampleErrands;
  }

  @override
  Future<ErrandModel> getErrandById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ExampleErrandListScreen.sampleErrands.firstWhere(
      (errand) => errand.id == id,
    );
  }

  @override
  Future<ErrandModel> updateErrand(ErrandModel errand) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Here you would make API call to update errand
    return errand;
  }

  @override
  Future<void> cancelErrand(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // API call to cancel errand
  }

  @override
  Future<ErrandModel> createErrand(ErrandModel errand) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // API call to create new errand
    return errand;
  }
}


