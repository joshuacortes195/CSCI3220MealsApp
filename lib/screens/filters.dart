import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
import 'package:meals_app/providers/filters_provider.dart'; 

// screen with the four filter switches
class FiltersScreen extends ConsumerWidget { // consumer widget so it can read providers
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider); // watches the filters so the switches update

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          // gluten-free switch
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!, // current on/off state
            onChanged: (isChecked) {
              // tells the provider to update this filter
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the title
            ),
            subtitle: Text(
              'Only include gluten-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the subtitle
            ),
            activeColor: Theme.of(context).colorScheme.tertiary, 
            contentPadding: const EdgeInsets.only(left: 34, right: 22), 
          ),
          // lactose-free switch
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!, 
            onChanged: (isChecked) {
              // tells the provider to update this filter
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the title
            ),
            subtitle: Text(
              'Only include lactose-free meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the subtitle
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          // vegetarian switch
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!, 
            onChanged: (isChecked) {
              // tells the provider to update this filter
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the title
            ),
            subtitle: Text(
              'Only include vegetarian meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the subtitle
            ),
            activeColor: Theme.of(context).colorScheme.tertiary, 
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          // vegan switch
          SwitchListTile(
            value: activeFilters[Filter.vegan]!, 
            onChanged: (isChecked) {
              // tells the provider to update this filter
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the title
            ),
            subtitle: Text(
              'Only include vegan meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ), // styling for the subtitle
            ),
            activeColor: Theme.of(context).colorScheme.tertiary, 
            contentPadding: const EdgeInsets.only(left: 34, right: 22), 
          ),
        ],
      ),
    );
  }
}