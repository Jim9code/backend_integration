import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactUsPage extends ConsumerWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Get in Touch', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Have questions or feedback? Fill out the form below or contact us directly.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            _ContactInfoTile(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@example.com',
              onTap: () {
                // TODO: Implement url_launcher to open email client.
              },
            ),
            _ContactInfoTile(
              icon: Icons.phone_outlined,
              title: 'Phone Support',
              subtitle: '+1 (800) 555-0123',
              onTap: () {
                // TODO: Implement url_launcher to open phone dialer.
              },
            ),
             _ContactInfoTile(
              icon: Icons.help_outline,
              title: 'Help Center & FAQ',
              subtitle: 'Find answers to common questions',
              onTap: () {
                // TODO: Navigate to FAQ page or open a webview.
              },
            ),

            const Divider(height: 40),

            Text('Send us a Message', style: theme.textTheme.titleLarge),
            const SizedBox(height: 16),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Your Name'),
                    validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Your Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email';
                      if (!value.contains('@')) return 'Please enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      labelText: 'Your Message',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                    validator: (value) => value!.isEmpty ? 'Please enter your message' : null,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // TODO: Implement actual message sending logic via a provider.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Message sent! We will get back to you shortly.')),
                        );
                        formKey.currentState!.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactInfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}
