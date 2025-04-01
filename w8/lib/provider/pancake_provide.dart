import 'package:app/async_value.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';

class Pancakeprovider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;
  Pancake? _editingPancake;

  Pancakeprovider(this._repository) {
    fetchUsers();
  }

  bool get isLoading =>
      pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData =>
      pancakesState != null && pancakesState!.state == AsyncValueState.success;
  bool get isEditing => _editingPancake != null;

  void fetchUsers() async {
    try {
      // 1- loading state
      pancakesState = AsyncValue.loading();
      notifyListeners();

      // 2 - Fetch users
      pancakesState = AsyncValue.success(await _repository.getPancakes());

      print("SUCCESS: list size ${pancakesState!.data!.length.toString()}");

      // 3 - Handle errors
    } catch (error) {
      print("ERROR: $error");
      pancakesState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  Future<void> addPancake(String color, double price) async {
    // 1- Call repo to add
    await _repository.addPancake(color: color, price: price);
    // 2- Call repo to fetch
    fetchUsers();
  }

  Future<void> deletePancake(String id) async {
    await _repository.deletePancake(id);
    fetchUsers();
  }

  Future<void> updatePancake(String id, String color, double price) async {
    await _repository.updatePancake(Pancake(id: id, color: color, price: price));
    _editingPancake = null; // Clear editing state
    fetchUsers();
  }

  void setEditingPancake(Pancake? pancake) {
    _editingPancake = pancake;
    notifyListeners();
  }

  //Clear editing state
  void cancelEditing() {
    _editingPancake = null;
    notifyListeners();
  }
}