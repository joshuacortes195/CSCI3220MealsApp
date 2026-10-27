// how hard a meal is to make
enum Complexity {
  simple,
  challenging,
  hard,
}

// how expensive a meal is
enum Affordability {
  affordable,
  pricey,
  luxurious,
}

// blueprint for a single meal
class Meal {
  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  }); // every field is required so a meal is never half filled in

  final String id; 
  final List<String> categories;
  final String title; 
  final String imageUrl; 
  final List<String> ingredients;
  final List<String> steps;
  final int duration; 
  final Complexity complexity; 
  final Affordability affordability;
  final bool isGlutenFree; 
  final bool isLactoseFree; 
  final bool isVegan; 
  final bool isVegetarian; 
}