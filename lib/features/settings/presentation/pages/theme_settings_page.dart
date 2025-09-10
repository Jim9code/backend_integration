import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/theme_provider.dart';

class ThemeSettingsPage extends ConsumerWidget {
  const ThemeSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: ListView(
        children: [
          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            subtitle: const Text('Use the light theme for the app.'),
            value: ThemeMode.light,
            groupValue: currentTheme,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeModeProvider.notifier).setThemeMode(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            subtitle: const Text('Use the dark theme for the app.'),
            value: ThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeModeProvider.notifier).setThemeMode(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            subtitle: const Text('Follow the system\'s theme setting.'),
            value: ThemeMode.system,
            groupValue: currentTheme,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeModeProvider.notifier).setThemeMode(value);
              }
            },
          ),
          // Optional: Primary Color Picker (as per prompt)
          const Divider(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Accent Color (Optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          ListTile(
            title: const Text('Primary Color'),
            subtitle: const Text('Choose a primary color for the app theme.'),
            trailing: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              radius: 14,
            ),
            onTap: () {
              // TODO: Implement a color picker dialog.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Color picker is not implemented.')),
              );
            },
          )
        ],
      ),
    );
  }
}
