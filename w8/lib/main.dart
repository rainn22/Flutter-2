// REPOSITORY
import 'dart:convert';
import 'dart:io';

import 'package:app/ui/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'async_value.dart';

// REPOS
abstract class PancakeRepository {
  Future<Pancake> addPancake({required String color, required double price});
  Future<List<Pancake>> getPancakes();
  Future<void> deletePancake(String id);
}

class FirebasePancakeRepository extends PancakeRepository {
  static const String baseUrl =
      'https://test-firebase-7aeb6-default-rtdb.asia-southeast1.firebasedatabase.app';
  static const String pancakesCollection = "pancakes";
  static const String allPancakesUrl = '$baseUrl/$pancakesCollection.json';

  @override
  Future<Pancake> addPancake(
      {required String color, required double price}) async {
    Uri uri = Uri.parse(allPancakesUrl);

    // Create a new data
    final newPancakeData = {'color': color, 'price': price};
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(newPancakeData),
    );

    // Handle errors
    if (response.statusCode != HttpStatus.ok) {
      throw Exception('Failed to add user');
    }

    // Firebase returns the new ID in 'name'
    final newId = json.decode(response.body)['name'];

    // Return created user
    return Pancake(id: newId, color: color, price: price);
  }

  @override
  Future<List<Pancake>> getPancakes() async {
    Uri uri = Uri.parse(allPancakesUrl);
    final http.Response response = await http.get(uri);

    // Handle errors
    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load');
    }

    // Return all users
    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) return [];
    return data.entries
        .map((entry) => PancakeDto.fromJson(entry.key, entry.value))
        .toList();
  }
  @override
  Future<void> deletePancake(String id) async {
    Uri uri = Uri.parse('$baseUrl/$pancakesCollection/$id.json');
    final response = await http.delete(uri);

    if (response.statusCode != HttpStatus.ok && response.statusCode != HttpStatus.noContent) {
      throw Exception('Failed to delete pancake');
    }
  }
}

// MODEL & DTO
class PancakeDto {
  static Pancake fromJson(String id, Map<String, dynamic> json) {
    return Pancake(id: id, color: json['color'], price: json['price']);
  }

  static Map<String, dynamic> toJson(Pancake pancake) {
    return {'name': pancake.color, 'price': pancake.price};
  }
}

// MODEL
class Pancake {
  final String id;
  final String color;
  final double price;

  Pancake({required this.id, required this.color, required this.price});

  @override
  bool operator ==(Object other) {
    return other is Pancake && other.id == id;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode;
}

// PROVIDER
class Pancakeprovider extends ChangeNotifier {
  final PancakeRepository _repository;
  AsyncValue<List<Pancake>>? pancakesState;

  Pancakeprovider(this._repository) {
    fetchUsers();
  }

  bool get isLoading =>
      pancakesState != null && pancakesState!.state == AsyncValueState.loading;
  bool get hasData =>
      pancakesState != null && pancakesState!.state == AsyncValueState.success;

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
}

// MAIN FUNCTION
void main() {
  final PancakeRepository pancakeRepository = FirebasePancakeRepository();

  runApp(
    ChangeNotifierProvider(
      create: (context) => Pancakeprovider(pancakeRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const App(),
      ),
    ),
  );
}
