# Build Runner Commands for Ocean Flutter Project

## Essential Commands

### 1. Clean and Generate All Code
```bash
# Clean previous builds and generate fresh code
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### 2. Watch Mode for Development
```bash
# Automatically regenerate code when files change
dart run build_runner watch --delete-conflicting-outputs
```

### 3. Clean Build Runner Cache
```bash
# If you encounter issues, clean the build runner cache
dart run build_runner clean
```

## Generated Files

The following files will be generated:
- `lib/core/models/user_model.g.dart`
- `lib/core/models/post_model.g.dart`
- `lib/core/models/product_model.g.dart`
- `lib/core/models/chat_model.g.dart`

## Troubleshooting

### Common Issues and Solutions

1. **Conflicting outputs error**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Build runner stuck**:
   ```bash
   dart run build_runner clean
   flutter clean
   flutter pub get
   dart run build_runner build --delete-conflicting-outputs
   ```

3. **Hive adapter conflicts**:
   - Ensure all `@HiveType(typeId: X)` have unique IDs
   - Register all adapters in `main.dart`

4. **JSON serialization issues**:
   - Verify all classes have `part 'filename.g.dart';`
   - Check that all fields are properly annotated

## Production Build Checklist

Before deploying to production:

1. ✅ Run `flutter analyze` (no errors)
2. ✅ Run `flutter test` (all tests pass)
3. ✅ Generate fresh code: `dart run build_runner build --delete-conflicting-outputs`
4. ✅ Test build: `flutter build apk --debug`
5. ✅ Commit `pubspec.lock` file
6. ✅ Push to repository for Codemagic build