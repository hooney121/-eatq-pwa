import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:eatq/features/common/views/splash_screen.dart';
import 'package:eatq/features/auth/views/login_screen.dart';
import 'package:eatq/features/auth/views/signup_screen.dart';
import 'package:eatq/features/auth/views/role_selection_screen.dart';
import 'package:eatq/features/customer/views/customer_home_screen.dart';
import 'package:eatq/features/store_owner/views/store_owner_home_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/customer',
      builder: (context, state) => const CustomerHomeScreen(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const CustomerHomeScreen(),
        ),
        // 기타 고객 경로...
      ],
    ),
    GoRoute(
      path: '/owner',
      builder: (context, state) => const StoreOwnerHomeScreen(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const StoreOwnerHomeScreen(),
        ),
        // 기타 점주 경로...
      ],
    ),
  ],
);