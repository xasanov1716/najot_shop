import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:najot_shop/data/firebase/category_service.dart';
import 'package:najot_shop/data/firebase/order_service.dart';
import 'package:najot_shop/data/firebase/product_service.dart';
import 'package:najot_shop/data/firebase/profile_service.dart';
import 'package:najot_shop/data/notification_service.dart';
import 'package:najot_shop/providers/auth_provider.dart';
import 'package:najot_shop/providers/category_provider.dart';
import 'package:najot_shop/providers/order_provider.dart';
import 'package:najot_shop/providers/product_provider.dart';
import 'package:najot_shop/providers/profile_provider.dart';
import 'package:najot_shop/providers/tab_provider.dart';
import 'package:najot_shop/providers/tab_provider_admin.dart';
import 'package:najot_shop/splash/splash_screen.dart';
import 'package:najot_shop/utils/app_colors.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.instance.init();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OrderProvider(orderService: OrderService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => TabAdminProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(
            productsService: ProductsService(),
          ),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            profileService: ProfileService(),
          ),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => TabProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(
            categoryService: CategoryService(),
          ),
          lazy: true,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.globalActive),
            useMaterial3: true,
          ),
        );
      },
      child: const SplashScreen(),
    );
  }
}
