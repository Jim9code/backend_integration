import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/auth_provider.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/seller_registration_page.dart';
import '../../features/main/presentation/pages/main_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/products/presentation/pages/products_page.dart';
import '../../features/products/presentation/pages/product_detail_page.dart';
import '../../features/upload/presentation/pages/upload_page.dart';
import '../../features/saved/presentation/pages/saved_page.dart';
import '../../features/chats/presentation/pages/chats_page.dart';
import '../../features/chats/presentation/pages/chat_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/market_survey/presentation/pages/market_survey_page.dart';
import '../../features/market_survey/presentation/pages/products_demand_page.dart';
import '../../features/market_survey/presentation/pages/distress_sales_page.dart';
import '../../features/market_survey/presentation/pages/heavy_distributors_page.dart';
import '../../features/market_survey/presentation/pages/swap_deals_page.dart';
import '../../features/market_survey/presentation/pages/auctions_page.dart';
import '../../features/market_survey/presentation/pages/swap_vendors_page.dart';
import '../../features/market_survey/presentation/pages/bulk_purchase_page.dart';
import '../../features/market_survey/presentation/pages/bulk_purchase_details_page.dart';
import '../../features/market_survey/presentation/pages/bulk_purchase_waitlist_page.dart';
import '../../features/market_survey/presentation/pages/bulk_purchase_oops_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/profile_settings_page.dart';
import '../../features/settings/presentation/pages/feed_settings_page.dart';
import '../../features/settings/presentation/pages/change_password_page.dart';
import '../../features/settings/presentation/pages/seller_settings_page.dart';
import '../../features/settings/presentation/pages/theme_settings_page.dart';
import '../../features/settings/presentation/pages/contact_us_page.dart';
import '../../features/settings/presentation/pages/legal_info_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isLoggedIn = authState != null;
      final isAuthRoute = state.matchedLocation.startsWith('/auth');
      final isSplashRoute = state.matchedLocation == '/splash';
      final isOnboardingRoute = state.matchedLocation == '/onboarding';
      
      // Allow splash and onboarding routes
      if (isSplashRoute || isOnboardingRoute) {
        return null;
      }
      
      if (!isLoggedIn && !isAuthRoute) {
        return '/auth/login';
      }
      
      if (isLoggedIn && isAuthRoute) {
        return '/';
      }
      
      return null;
    },
    routes: [
      // Splash Route
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const SplashPage(),
      ),
      
      // Onboarding Route
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      
      // Auth Routes
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/auth/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/auth/otp',
        name: 'otp',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OTPPage(
            email: extra?['email'] ?? '',
            userId: extra?['userId'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/auth/seller-registration',
        name: 'seller-registration',
        builder: (context, state) => const SellerRegistrationPage(),
      ),
      
      // Main App Routes
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/products',
            name: 'products',
            builder: (context, state) => const ProductsPage(),
            routes: [
              GoRoute(
                path: ':productId', // Fixed: Removed leading slash
                name: 'product-detail',
                builder: (context, state) => ProductDetailPage(
                  productId: state.pathParameters['productId']!,
                ),
              ),
            ],
          ),
          GoRoute(
            path: '/upload',
            name: 'upload',
            builder: (context, state) => const UploadPage(),
          ),
          GoRoute(
            path: '/saved',
            name: 'saved',
            builder: (context, state) => const SavedPage(),
          ),
          GoRoute(
            path: '/chats',
            name: 'chats',
            builder: (context, state) => const ChatsPage(),
            routes: [
              GoRoute(
                path: ':chatId', // Fixed: Removed leading slash
                name: 'chat-detail',
                builder: (context, state) => ChatDetailPage(
                  chatId: state.pathParameters['chatId']!,
                ),
              ),
            ],
          ),
        ],
      ),
      
      // Profile Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/profile/:userId',
        name: 'user-profile',
        builder: (context, state) => ProfilePage(
          userId: state.pathParameters['userId']!,
        ),
      ),
      
      // Market Survey Routes
      GoRoute(
        path: '/market-survey',
        name: 'market-survey',
        builder: (context, state) => const MarketSurveyPage(),
      ),
      GoRoute(
        path: '/products-demand',
        name: 'products-demand',
        builder: (context, state) => const ProductsDemandPage(),
      ),
      GoRoute(
        path: '/distress-sales',
        name: 'distress-sales',
        builder: (context, state) => const DistressSalesPage(),
      ),
      GoRoute(
        path: '/heavy-distributors',
        name: 'heavy-distributors',
        builder: (context, state) => const HeavyDistributorsPage(),
      ),
      GoRoute(
        path: '/swap-deals',
        name: 'swap-deals',
        builder: (context, state) => const SwapDealsPage(),
      ),
       GoRoute(
        path: '/auctions',
        name: 'auctions',
        builder: (context, state) => const AuctionsPage(),
      ),
      GoRoute(
        path: '/swap-vendors',
        name: 'swap-vendors',
        builder: (context, state) => const SwapVendorsPage(),
      ),
      GoRoute(
        path: '/bulk-purchase',
        name: 'bulk-purchase',
        builder: (context, state) => const BulkPurchasePage(),
      ),
      GoRoute(
        path: '/bulk-purchase-details',
        name: 'bulk-purchase-details',
        builder: (context, state) => const BulkPurchaseDetailsPage(),
      ),
      GoRoute(
        path: '/bulk-purchase-waitlist',
        name: 'bulk-purchase-waitlist',
        builder: (context, state) => const BulkPurchaseWaitlistPage(),
      ),
      GoRoute(
        path: '/bulk-purchase-oops',
        name: 'bulk-purchase-oops',
        builder: (context, state) => const BulkPurchaseOopsPage(),
      ),
      
      // Settings Routes
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile-settings',
            builder: (context, state) => const ProfileSettingsPage(),
          ),
          GoRoute(
            path: 'feed',
            name: 'feed-settings',
            builder: (context, state) => const FeedSettingsPage(),
          ),
          GoRoute(
            path: 'password',
            name: 'password-settings',
            builder: (context, state) => const ChangePasswordPage(),
          ),
          GoRoute(
            path: 'seller',
            name: 'seller-settings',
            builder: (context, state) => const SellerSettingsPage(),
          ),
          GoRoute(
            path: 'theme',
            name: 'theme-settings',
            builder: (context, state) => const ThemeSettingsPage(),
          ),
          GoRoute(
            path: 'contact',
            name: 'contact-us',
            builder: (context, state) => const ContactUsPage(),
          ),
          GoRoute(
            path: 'legal',
            name: 'legal-info',
            builder: (context, state) => const LegalInfoPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});