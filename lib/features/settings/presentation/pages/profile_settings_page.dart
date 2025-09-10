import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Create a provider to handle profile update logic.
// final profileSettingsProvider = StateNotifierProvider<...>(...);

class ProfileSettingsPage extends ConsumerWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: In a real app, load the user's current data into the controllers.
    final nameController = TextEditingController(text: "John Doe");
    final usernameController = TextEditingController(text: "johndoe");
    final bioController = TextEditingController(text: "Just a regular user exploring the app.");
    final locationController = TextEditingController(text: "San Francisco, CA");

    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // TODO: Call a provider method to save the data.
                // ref.read(profileSettingsProvider.notifier).updateProfile(...);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully!')),
                );
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Avatar and Cover Photo Pickers
              Stack(
                alignment: Alignment.center,
                children: [
                  // Cover Photo
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://picsum.photos/seed/cover/800/300'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        onPressed: () {
                          // TODO: Implement cover photo picker.
                        },
                      ),
                    ),
                  ),
                  // Avatar
                  Positioned(
                    top: 100,
                    child: Stack(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=john_doe_id'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: theme.colorScheme.primary,
                            child: IconButton(
                              icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                              onPressed: () {
                                // TODO: Implement avatar picker.
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70), // Space for overlapping avatar

              // Form Fields
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Please enter your full name' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) => value!.isEmpty ? 'Please enter a username' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: bioController,
                decoration: const InputDecoration(labelText: 'Bio / Tagline'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
