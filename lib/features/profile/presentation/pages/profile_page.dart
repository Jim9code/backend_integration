import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/providers/auth_provider.dart';

// TODO: Replace with a real implementation that fetches user data from a repository.
/// Provider to fetch a user profile by their ID.
final userProfileProvider = FutureProvider.family<User, String>((ref, userId) async {
  // This is a placeholder implementation.
  // In a real app, you would fetch user data from your backend/service layer.
  // For now, we'll return a dummy user.
  // We can simulate a network delay.
  await Future.delayed(const Duration(milliseconds: 500));

  // Dummy Seller User for demonstration
  if (userId == 'seller_id' || userId.hashCode.isEven) { // Also make some other users sellers for variety
    return User(
      id: userId,
      email: 'seller.$userId@example.com',
      fullName: 'The Artful Seller',
      profilePicture: 'https://i.pravatar.cc/150?u=$userId',
      bio: 'Purveyor of fine goods and artifacts.',
      location: 'New York, USA',
      role: UserRole.seller,
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
      followersCount: 1250,
      followingCount: 89,
      postsCount: 75,
      isVerified: true,
      sellerProfile: SellerProfile(
        businessName: 'The Artful Seller Co.',
        businessCategory: BusinessCategory.retailer,
        businessLocation: '123 Market St, New York',
        businessPhone: '+1 123-456-7890',
        businessEmail: 'contact@artfulseller.com',
        businessDescription: 'We specialize in handcrafted items from around the world. Quality and authenticity are our cornerstones.',
        businessWebsite: 'https://example.com',
        personalId: 'dummy_personal_id',
      ),
    );
  }

  // Dummy Regular User
  return User(
    id: userId,
    email: 'user.$userId@example.com',
    fullName: 'John Doe',
    profilePicture: 'https://i.pravatar.cc/150?u=$userId',
    bio: 'Just a regular user exploring the app.',
    location: 'San Francisco, CA',
    role: UserRole.buyer,
    createdAt: DateTime.now().subtract(const Duration(days: 180)),
    updatedAt: DateTime.now(),
    followersCount: 150,
    followingCount: 200,
    postsCount: 25,
  );
});


/// The main profile page, which can display either the current user's profile
/// or another user's profile, specified by [userId].
class ProfilePage extends ConsumerWidget {
  /// If [userId] is null, it displays the profile of the currently logged-in user.
  final String? userId;

  const ProfilePage({super.key, this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAuthUser = ref.watch(currentUserProvider);
    final targetUserId = userId ?? currentAuthUser?.id;

    if (targetUserId == null) {
      // This can happen if the user is not logged in and no userId is provided.
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('No user profile to display.'),
        ),
      );
    }

    // Use a dummy user for the logged-in user if they don't exist in our dummy provider
    // In a real app, currentUserProvider would return a full User object.
    final finalTargetUserId = (userId == null && currentAuthUser != null) ? currentAuthUser.id : targetUserId;

    final userAsyncValue = ref.watch(userProfileProvider(finalTargetUserId));

    return Scaffold(
      body: userAsyncValue.when(
        data: (user) {
          final isOwnProfile = user.id == currentAuthUser?.id;
          if (user.role == UserRole.seller) {
            return _SellerProfileView(user: user, isOwnProfile: isOwnProfile);
          } else {
            return _UserProfileView(user: user, isOwnProfile: isOwnProfile);
          }
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading profile: $err')),
      ),
    );
  }
}

/// Renders the profile view for a regular user (buyer).
class _UserProfileView extends ConsumerWidget {
  final User user;
  final bool isOwnProfile;

  const _UserProfileView({required this.user, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: _ProfileHeader(user: user, isOwnProfile: isOwnProfile),
          ),
          actions: [
            if (!isOwnProfile)
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                if (user.bio != null) ...[
                  const SizedBox(height: 4),
                  Text(user.bio!, style: theme.textTheme.bodyMedium),
                ],
                const SizedBox(height: 16),
                _StatsRow(user: user),
                const SizedBox(height: 16),
                _InfoSection(user: user),
                const SizedBox(height: 24),
                Text("Posts", style: theme.textTheme.titleLarge),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _PostCard(index: index),
              childCount: user.postsCount,
            ),
          ),
        ),
      ],
    );
  }
}

/// Renders the profile view for a seller.
class _SellerProfileView extends ConsumerWidget {
  final User user;
  final bool isOwnProfile;

  const _SellerProfileView({required this.user, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sellerProfile = user.sellerProfile;

    if (sellerProfile == null) {
      return const Center(child: Text('Seller data is not available.'));
    }

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false,
          pinned: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: _ProfileHeader(user: user, isOwnProfile: isOwnProfile),
          ),
           actions: [
            if (!isOwnProfile)
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(sellerProfile.businessName, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                Text(sellerProfile.businessCategory.name.toUpperCase(), style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.secondary, letterSpacing: 1.1)),
                const SizedBox(height: 16),
                _StatsRow(user: user),
                const SizedBox(height: 16),
                // TODO: Add seller-specific stats like ratings.
                _InfoSection(user: user, isSeller: true),
                const SizedBox(height: 24),
                Text("Products", style: theme.textTheme.titleLarge),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ProductCard(index: index),
              childCount: user.postsCount,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileHeader extends ConsumerWidget {
  final User user;
  final bool isOwnProfile;

  const _ProfileHeader({required this.user, required this.isOwnProfile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Cover Photo
        Positioned.fill(
          child: Image.network(
            'https://picsum.photos/seed/${user.id}/800/400', // Dummy cover
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(color: theme.colorScheme.secondaryContainer),
          ),
        ),
        // Action Buttons
        Positioned(
          bottom: 16,
          right: 16,
          child: isOwnProfile
              ? ElevatedButton.icon(
                  onPressed: () => context.go('/settings/profile'),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit Profile'),
                )
              : Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement follow/unfollow logic using a provider.
                      },
                      child: const Text('Follow'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        // TODO: Ensure chat feature uses this navigation pattern.
                        // This assumes a 1-on-1 chat is identified by the other user's ID.
                        context.go('/chats/${user.id}');
                      },
                      child: const Text('Message'),
                    ),
                  ],
                ),
        ),
         // Profile Avatar
        Positioned(
          bottom: -40, // Overlap
          left: 16,
          child: Semantics(
            label: "Profile picture for ${user.fullName}",
            child: CircleAvatar(
              radius: 50,
              backgroundColor: theme.scaffoldBackgroundColor,
              child: CircleAvatar(
                radius: 46,
                backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
                child: user.profilePicture == null ? Text(user.fullName.substring(0, 1).toUpperCase(), style: theme.textTheme.headlineLarge) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  final User user;
  const _StatsRow({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0), // Space for overlapping avatar
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 120), // Placeholder to balance the avatar space
          Expanded(child: _StatItem(count: user.postsCount, label: 'Posts')),
          Expanded(child: _StatItem(count: user.followersCount, label: 'Followers')),
          Expanded(child: _StatItem(count: user.followingCount, label: 'Following')),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final int count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count.toString(), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final User user;
  final bool isSeller;

  const _InfoSection({required this.user, this.isSeller = false});

  @override
  Widget build(BuildContext context) {
    final joinedDate = user.createdAt;
    final joinedYear = joinedDate.year;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (user.location != null) _InfoRow(icon: Icons.location_on_outlined, text: user.location!),
        _InfoRow(icon: Icons.calendar_today_outlined, text: 'Joined in $joinedYear'),
        if (isSeller && user.sellerProfile?.businessWebsite != null)
          _InfoRow(icon: Icons.link_outlined, text: user.sellerProfile!.businessWebsite!, isLink: true),
        if (isSeller && user.sellerProfile?.businessDescription != null) ...[
            const SizedBox(height: 12),
            Text("About", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(user.sellerProfile!.businessDescription!, style: Theme.of(context).textTheme.bodyMedium),
        ]
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLink;

  const _InfoRow({required this.icon, required this.text, this.isLink = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: theme.textTheme.bodySmall?.color),
          const SizedBox(width: 12),
          Text(
            text,
            style: isLink
                ? theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)
                : theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

/// Placeholder for a user's post in a grid.
class _PostCard extends StatelessWidget {
  final int index;
  const _PostCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Post number ${index + 1}",
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage('https://picsum.photos/seed/${index + 100}/300/300'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

/// Placeholder for a seller's product in a grid.
class _ProductCard extends StatelessWidget {
  final int index;
  const _ProductCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: "Product: Product Name ${index + 1}, price \$${(index * 5 + 19.99).toStringAsFixed(2)}",
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://picsum.photos/seed/${index + 200}/400/400'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Name ${index + 1}', style: theme.textTheme.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  Text('\$${(index * 5 + 19.99).toStringAsFixed(2)}', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
