import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/app_design.dart';
import '../../providers/auth_state_provider.dart';
import '../dashboard/dashboard_screen.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  ConsumerState<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends ConsumerState<EmailVerificationScreen> {
  bool _isChecking = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    // Auto-check verification status every 3 seconds
    _startAutoCheck();
  }

  void _startAutoCheck() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _checkEmailVerified();
      }
    });
  }

  Future<void> _checkEmailVerified() async {
    if (_isChecking) return;

    setState(() {
      _isChecking = true;
      _message = null;
    });

    try {
      final authService = ref.read(firebaseAuthServiceProvider);
      await authService.reloadUser();

      if (authService.isEmailVerified) {
        if (mounted) {
          // Navigate to dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        }
      } else {
        setState(() {
          _message = 'Email not verified yet. Please check your inbox.';
          _isChecking = false;
        });
        // Continue auto-checking
        _startAutoCheck();
      }
    } catch (e) {
      setState(() {
        _message = 'Error checking verification status.';
        _isChecking = false;
      });
      _startAutoCheck();
    }
  }

  Future<void> _resendVerificationEmail() async {
    setState(() {
      _isChecking = true;
      _message = null;
    });

    final authService = ref.read(firebaseAuthServiceProvider);
    final result = await authService.resendEmailVerification();

    if (mounted) {
      setState(() {
        _message = result.message;
        _isChecking = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result.message),
          backgroundColor: result.success ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkBg, AppColors.accent.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: AppDesign.glassDecoration(radius: 30),
                  child: const Icon(
                    Icons.mark_email_unread_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Verify Your Email',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We sent a verification email to:',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Please check your inbox and click the verification link.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                if (_isChecking)
                  const SpinKitFoldingCube(
                    color: Colors.white,
                    size: 30.0,
                  )
                else
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: _checkEmailVerified,
                        icon: const Icon(Icons.refresh_rounded),
                        label: Text(
                          'I\'ve Verified',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton.icon(
                        onPressed: _resendVerificationEmail,
                        icon: const Icon(Icons.email_outlined),
                        label: Text(
                          'Resend Email',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                if (_message != null) ...[
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: AppDesign.glassDecoration(radius: 12),
                    child: Text(
                      _message!,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () async {
                    final authService = ref.read(firebaseAuthServiceProvider);
                    await authService.signOut();
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Back to Login',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.white38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
