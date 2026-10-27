import 'package:flutter/material.dart'; 

// side menu that slides out from the left
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen; // tells the tabs screen which option was tapped

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // header at the top of the drawer
          DrawerHeader(
            padding: const EdgeInsets.all(20), 
            // header background gradient
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer, 
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8), 
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight, 
              ),
            ),
            // food icon next to the app name
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ), // styling for the header icon
                const SizedBox(width: 18),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ), // styling for the header text
                ),
              ],
            ),
          ),
          // meals option
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ), // styling for the icon
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ), // styling for the text
            ),
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          // filters option
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 26,
              color: Theme.of(context).colorScheme.onBackground,
            ), // styling for the icon
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 24,
                  ), // styling for the text
            ),
            onTap: () {
              onSelectScreen('filters'); // opens the filters screen
            },
          ),
        ],
      ),
    );
  }
}