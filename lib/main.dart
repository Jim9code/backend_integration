import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/providers/theme_provider.dart';
import 'core/models/user_model.dart';
import 'core/models/post_model.dart';
import 'core/models/product_model.dart';
import 'core/models/chat_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register Hive Adapters - Updated for latest Hive version
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SellerProfileAdapter());
  Hive.registerAdapter(SellerAnalyticsAdapter());
  Hive.registerAdapter(UserRoleAdapter());
  Hive.registerAdapter(BusinessCategoryAdapter());
  Hive.registerAdapter(SellerStatusAdapter());
  Hive.registerAdapter(SubscriptionPlanAdapter());
  
  // Register additional adapters for other models
  Hive.registerAdapter(PostAdapter());
  Hive.registerAdapter(PostMediaAdapter());
  Hive.registerAdapter(PostEngagementAdapter());
  Hive.registerAdapter(CommentAdapter());
  Hive.registerAdapter(PostCategoryAdapter());
  Hive.registerAdapter(PostMediaTypeAdapter());
  Hive.registerAdapter(PostStatusAdapter());
  
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(ARModelAdapter());
  Hive.registerAdapter(ProductDimensionsAdapter());
  Hive.registerAdapter(ProductCategoryAdapter());
  Hive.registerAdapter(ProductConditionAdapter());
  Hive.registerAdapter(ProductStatusAdapter());
  
  Hive.registerAdapter(ChatAdapter());
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(MessageAttachmentAdapter());
  Hive.registerAdapter(ChatTypeAdapter());
  Hive.registerAdapter(MessageTypeAdapter());
  Hive.registerAdapter(MessageStatusAdapter());
  Hive.registerAdapter(MessageAttachmentTypeAdapter());
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    const ProviderScope(
      child: OceanApp(),
    ),
  );
}

class OceanApp extends ConsumerWidget {
  const OceanApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(routerProvider);
    
    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        );
      },
    );
  }
}