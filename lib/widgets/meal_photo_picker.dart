import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:meals_app/providers/meal_photos_provider.dart';

// created a your photo section on the meal details screen
class MealPhotoPicker extends ConsumerWidget {
  const MealPhotoPicker({super.key, required this.mealId});

  final String mealId;

  // opens the gallery then copies the chosen image into app storage and saves its path
  Future<void> _pickPhoto(BuildContext context, WidgetRef ref) async {
    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      imageQuality: 85,
    );
    // edge for if user backs out of gallery
    if (picked == null) return;

    // copy users selected image and store so we can use it later
    final dir = await getApplicationDocumentsDirectory();
    final fileName =
        'meal_${mealId}_${DateTime.now().millisecondsSinceEpoch}'
        '${p.extension(picked.path)}';
    final saved = await File(picked.path).copy(p.join(dir.path, fileName));

    if (!context.mounted) return;
    ref.read(mealPhotosProvider.notifier).setPhoto(mealId, saved.path);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photoPath = ref.watch(mealPhotosProvider)[mealId];
    final hasPhoto = photoPath != null && File(photoPath).existsSync();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 180,
            child: hasPhoto
                ? Image.file(File(photoPath), fit: BoxFit.cover)
                : Container(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined, size: 40),
                        SizedBox(height: 8),
                        Text('Add your own photo of this meal'),
                      ],
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (hasPhoto)
                  TextButton.icon(
                    onPressed: () =>
                        ref.read(mealPhotosProvider.notifier).removePhoto(mealId),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Remove'),
                  ),
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => _pickPhoto(context, ref),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: Text(hasPhoto ? 'Change photo' : 'Choose photo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}