// Define routes here, add auth guard later if needed
import 'package:droplet/features/auth/presentation/pages/auth_page.dart';
import 'package:droplet/features/auth/presentation/pages/login_page.dart';
import 'package:droplet/features/splash/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),

    // GoRoute(
    //   path: '/signup',
    //   name: 'signup',
    //   builder: (context, state) => const SignUpPage(),
    // ),
    // GoRoute(
    //   path: '/home',
    //   name: 'home',
    //   builder: (context, state) => const HomePage(),
    // ),
    // GoRoute(
    //   path: '/nav',
    //   name: 'nav',
    //   builder: (context, state) => const NavPage(),
    // ),
    // GoRoute(
    //   path: '/checkout',
    //   name: 'checkout',
    //   builder: (context, state) => const CheckoutPage(),
    // ),
    // GoRoute(
    //   path: '/cart',
    //   name: 'cart',
    //   builder: (context, state) => const CartPage(),
    // ),
    // GoRoute(
    //   path: '/search',
    //   name: 'search',
    //   builder: (context, state) => const SearchPage(),
    // ),
    // GoRoute(
    //   path: '/success',
    //   name: 'success',
    //   builder: (context, state) => const SuccesfulOrderPage(),
    // ),
  ],
);
