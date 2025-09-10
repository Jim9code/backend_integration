import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/providers/auth_provider.dart';

/// A hub page that lists all the different settings categories.
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Account'),
          _SettingsTile(
            icon: Icons.person_outline,
            title: 'Profile Settings',
            onTap: () => context.go('/settings/profile'),
          ),
          _SettingsTile(
            icon: Icons.feed_outlined,
            title: 'Feed Settings',
            onTap: () => context.go('/settings/feed'),
          ),
          _SettingsTile(
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () => context.go('/settings/password'),
          ),
          // Conditionally show Seller Settings based on user role
          if (currentUser?.role == UserRole.seller)
            _SettingsTile(
              icon: Icons.store_outlined,
              title: 'Seller Settings',
              onTap: () => context.go('/settings/seller'),
            ),
          const Divider(),
          _buildSectionHeader(context, 'Preferences'),
           _SettingsTile(
            icon: Icons.palette_outlined,
            title: 'Theme',
            onTap: () => context.go('/settings/theme'),
          ),
          const Divider(),
          _buildSectionHeader(context, 'Support & Legal'),
          _SettingsTile(
            icon: Icons.support_agent_outlined,
            title: 'Contact Us',
            onTap: () => context.go('/settings/contact'),
          ),
          _SettingsTile(
            icon: Icons.gavel_outlined,
            title: 'Legal Information',
            onTap: () => context.go('/settings/legal'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
            onTap: () => _showSignOutDialog(context, ref),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Padding _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Pop dialog and then call sign out.
              // The router's redirect logic will handle navigation to the login screen.
              context.pop();
              ref.read(authControllerProvider.notifier).signOut();
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}
