import 'package:flutter/material.dart'; 
import 'package:transparent_image/transparent_image.dart'; 

import 'package:meals_app/widgets/meal_item_trait.dart'; 
import 'package:meals_app/models/meal.dart'; 

// card for one meal in the list, picture with info on top
class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectMeal,
  });

  final Meal meal; // the meal this card shows
  final void Function(Meal meal) onSelectMeal; // runs when the card is tapped

  // turns "simple" into "Simple" for the card
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  // turns "pricey" into "Pricey" for the card
  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    // card styling
    return Card(
      margin: const EdgeInsets.all(8), 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ), // rounded corners
      clipBehavior: Clip.hardEdge, 
      // makes the whole card tappable
      elevation: 2, 
      child: InkWell(
        onTap: () {
          onSelectMeal(meal); // opens this meal's details
        },
        // stacks the info bar on top of the picture
        child: Stack(
          children: [
            // meal picture that fades in once it loads
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage), 
              image: NetworkImage(meal.imageUrl), 
              fit: BoxFit.cover, 
              height: 200,
              width: double.infinity, 
            ),
            // dark info bar pinned to the bottom of the picture
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54, 
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    // meal title
                    Text(
                      meal.title,
                      maxLines: 2, 
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, 
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ), // styling for the title
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ), // how long it takes
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ), // how hard it is
                        const SizedBox(width: 12),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ) // how much it costs
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}