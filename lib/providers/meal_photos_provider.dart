import 'dart:io';
import 'package:flutter_riverpod/legacy.dart';

// this holds the photo path for each meal by meal id
class MealPhotosNotifier extends StateNotifier<Map<String, String>> {
  MealPhotosNotifier() : super({});

  // saves the photo and cleans up the old file
  void setPhoto(String mealId, String path) {
    _deleteFile(state[mealId]);
    state = {...state, mealId: path};
  }

  // removes the photo
  void removePhoto(String mealId) {
    _deleteFile(state[mealId]);
    state = {...state}..remove(mealId);
  }

  void _deleteFile(String? path) {
    if (path == null) return;
    final file = File(path);
    if (file.existsSync()) file.deleteSync();
  }
}

// provides the map of meal id which points to photo
final mealPhotosProvider =
    StateNotifierProvider<MealPhotosNotifier, Map<String, String>>(
  (ref) => MealPhotosNotifier(),
);