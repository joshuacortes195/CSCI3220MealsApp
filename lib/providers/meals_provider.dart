import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_app/data/dummy_data.dart';

// hands every screen the full list of meals from our dummy data
final mealsProvider = Provider((ref) {
  return dummyMeals;
});