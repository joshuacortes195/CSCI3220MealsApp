import 'package:flutter/material.dart'; 

// small icon plus label used on the meal card, like time or price
class MealItemTrait extends StatelessWidget {
  const MealItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    // icon and text side by side
    return Row(children: [
      Icon(
        icon,
        size: 17,
        color: Colors.white,
      ), // styling for the icon
      const SizedBox(width: 6),
      Text(
        label,
        style: const TextStyle(
          color: Colors.white,
        ), // styling for the label text
      ),
    ]);
  }
}