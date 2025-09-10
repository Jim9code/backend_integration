import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Create a provider (e.g., StateNotifierProvider) to manage and persist these settings.
// For example:
// final feedSettingsProvider = StateNotifierProvider<FeedSettingsNotifier, FeedSettingsState>((ref) {
//   return FeedSettingsNotifier();
// });

class FeedSettingsPage extends ConsumerStatefulWidget {
  const FeedSettingsPage({super.key});

  @override
  ConsumerState<FeedSettingsPage> createState() => _FeedSettingsPageState();
}

class _FeedSettingsPageState extends ConsumerState<FeedSettingsPage> {
  // TODO: These values should come from the feedSettingsProvider.
  bool _showLikesAndComments = true;
  bool _newPostNotifications = false;
  final List<String> _allCategories = ['Fashion', 'Electronics', 'Home', 'Books', 'Sports', 'Beauty'];
  final Set<String> _selectedCategories = {'Fashion', 'Electronics'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Section: Content Preferences
          Text('Content Preferences', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Choose the categories you want to see more of in your feed.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _allCategories.map((category) {
              final isSelected = _selectedCategories.contains(category);
              return FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedCategories.add(category);
                    } else {
                      _selectedCategories.remove(category);
                    }
                    // TODO: Update the provider state.
                  });
                },
                selectedColor: theme.colorScheme.primaryContainer,
                checkmarkColor: theme.colorScheme.onPrimaryContainer,
              );
            }).toList(),
          ),
          const Divider(height: 40),

          // Section: Privacy
          Text('Privacy on Your Profile', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Show likes and comments'),
            subtitle: const Text('Allow others to see the like and comment counts on your posts.'),
            value: _showLikesAndComments,
            onChanged: (value) {
              setState(() {
                _showLikesAndComments = value;
                // TODO: Update the provider state.
              });
            },
          ),
          const Divider(height: 40),

          // Section: Notifications
          Text('Notifications', style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('New post notifications'),
            subtitle: const Text('Get notified when users you follow create a new post.'),
            value: _newPostNotifications,
            onChanged: (value) {
              setState(() {
                _newPostNotifications = value;
                // TODO: Update the provider state.
              });
            },
          ),
        ],
      ),
    );
  }
}
