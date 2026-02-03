import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Authentication Service
/// Handles all authentication operations including signup, login, password reset, and email verification
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Auth state changes stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  /// Automatically sends email verification
  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      // Create user account
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      await userCredential.user?.updateDisplayName(displayName);

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      return AuthResult(
        success: true,
        message: 'Account created! Please check your email to verify your account.',
        user: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
        errorCode: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Sign in with email and password
  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        return AuthResult(
          success: false,
          message: 'Please verify your email before signing in.',
          user: userCredential.user,
          requiresEmailVerification: true,
        );
      }

      return AuthResult(
        success: true,
        message: 'Welcome back!',
        user: userCredential.user,
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
        errorCode: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult(
        success: true,
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
        errorCode: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to send password reset email. Please try again.',
      );
    }
  }

  /// Resend email verification
  Future<AuthResult> resendEmailVerification() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return AuthResult(
          success: false,
          message: 'No user is currently signed in.',
        );
      }

      if (user.emailVerified) {
        return AuthResult(
          success: false,
          message: 'Email is already verified.',
        );
      }

      await user.sendEmailVerification();
      return AuthResult(
        success: true,
        message: 'Verification email sent! Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(
        success: false,
        message: _getErrorMessage(e.code),
        errorCode: e.code,
      );
    } catch (e) {
      return AuthResult(
        success: false,
        message: 'Failed to send verification email. Please try again.',
      );
    }
  }

  /// Reload current user to get updated email verification status
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  /// Check if email is verified
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  /// Get user-friendly error messages
  String _getErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'Password is too weak. Please use at least 6 characters.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'invalid-email':
        return 'Invalid email address format.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'operation-not-allowed':
        return 'Email/password sign-in is not enabled.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}

/// Authentication result model
class AuthResult {
  final bool success;
  final String message;
  final User? user;
  final String? errorCode;
  final bool requiresEmailVerification;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
    this.errorCode,
    this.requiresEmailVerification = false,
  });
}
