import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';

/// Firebase Auth Service Provider
final firebaseAuthServiceProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

/// Auth State Stream Provider
/// Provides real-time updates when user signs in/out
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(firebaseAuthServiceProvider);
  return authService.authStateChanges;
});

/// Current User Provider
/// Returns the currently authenticated user or null
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Auth Loading State Provider
final authLoadingProvider = StateProvider<bool>((ref) => false);

/// Auth Error Message Provider
final authErrorProvider = StateProvider<String?>((ref) => null);
