import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/user_model.dart';

// TODO: Create a provider to handle seller profile updates.
// final sellerSettingsProvider = StateNotifierProvider<...>(...);

class SellerSettingsPage extends ConsumerWidget {
  const SellerSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Load real seller data from a provider.
    final businessNameController = TextEditingController(text: "The Artful Seller Co.");
    final descriptionController = TextEditingController(text: "We specialize in handcrafted items from around the world.");
    final contactInfoController = TextEditingController(text: "contact@artfulseller.com");
    final shippingPolicyController = TextEditingController(text: "Ships within 3-5 business days.");

    final formKey = GlobalKey<FormState>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // TODO: Call provider to save seller settings.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Seller settings updated!')),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Business Information', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: businessNameController,
                decoration: const InputDecoration(labelText: 'Business Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a business name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<BusinessCategory>(
                value: BusinessCategory.retailer, // TODO: Get from provider
                decoration: const InputDecoration(labelText: 'Role'),
                items: BusinessCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name[0].toUpperCase() + category.name.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  // TODO: Update provider state
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Business Description'),
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: contactInfoController,
                decoration: const InputDecoration(labelText: 'Public Contact Info (Email/Phone)'),
              ),
              const Divider(height: 40),

              Text('Policies & Payments', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              TextFormField(
                controller: shippingPolicyController,
                decoration: const InputDecoration(labelText: 'Shipping Policy'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.payment),
                title: const Text('Payment Details'),
                subtitle: const Text('Update your bank account for payouts'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: Navigate to a dedicated payment details page.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment details page not implemented.')),
                  );
                },
              ),
              const Divider(height: 40),

              Text('Analytics', style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),
              // Placeholder for an analytics chart/widget
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Card(
                  color: theme.colorScheme.surfaceVariant,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart, size: 40),
                        SizedBox(height: 8),
                        Text('Sales Analytics Placeholder'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
