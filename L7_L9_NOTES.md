# L7 + L9 Notes

## L7 (Navigation): Favorites screen
**New file:** `lib/screens/favorites.dart`
- Lists the meals you starred. Tap one to open its details.
- Swipe a meal left to remove it (there's an Undo button).
- Trash icon at the top clears all favorites (asks to confirm first).
- Shows "No favorites yet" when the list is empty.

**Changed:**
- `lib/screens/tabs.dart` uses the new screen for the Favorites tab.
- `lib/widgets/main_drawer.dart` has a new Favorites option that opens the screen.

## L9 (Persistence): favorites saved in SQLite
**New file:** `lib/data/favorites_db.dart`
- Local database that saves the id of each favorite meal.
- Has functions to load, add, remove and clear favorites.

**New files:** `web/sqlite3.wasm`, `web/sqflite_sw.js`
- Let SQLite run in Chrome.

**Changed:**
- `lib/providers/favorites_provider.dart` loads saved favorites when the app starts and saves every change to the database.
- `pubspec.yaml` adds the `sqflite` and `sqflite_common_ffi_web` packages.

## Other fixes
- `lib/main.dart` wraps the app in `ProviderScope` (it crashed without it) and hides the red debug banner, which was covering the star button.

## Run it
```
flutter pub get
flutter run -d chrome
```
