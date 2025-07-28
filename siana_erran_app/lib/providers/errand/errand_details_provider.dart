
import 'package:flutter/material.dart';
import 'package:siana_erran_app/core/models/Errands/errands_model.dart';
import 'package:siana_erran_app/core/services/Errand/repository/details_erran_repo.dart';

class ErrandProvider extends ChangeNotifier {
  final ErrandRepository _repository;
  List<ErrandModel> _errands = [];
  bool _isLoading = false;
  String? _error;

  ErrandProvider(this._repository);

  List<ErrandModel> get errands => _errands;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadErrands() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _errands = await _repository.getErrands();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateErrand(ErrandModel errand) async {
    try {
      final updatedErrand = await _repository.updateErrand(errand);
      final index = _errands.indexWhere((e) => e.id == errand.id);
      if (index != -1) {
        _errands[index] = updatedErrand;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> cancelErrand(String id) async {
    try {
      await _repository.cancelErrand(id);
      final index = _errands.indexWhere((e) => e.id == id);
      if (index != -1) {
        _errands[index] = _errands[index].copyWith(
          status: ErrandStatus.cancelled,
        );
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}

