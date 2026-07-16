import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../helpers/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a 3-second initialization delay before moving forward
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navigate to the DashboardScreen after the delay
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Larger centered logo
              Image.asset(
                'docs/assets/bu_logo_placeholder.png',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.school_rounded,
                  size: 120,
                  color: BUColors.primaryBlue,
                ),
              ),
              const SizedBox(height: 32),
              // University Application Branding Labels
              Text(
                loc.appTitle,
                style: const TextStyle(
                  color: BUColors.primaryBlue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                loc.bugemaCompanion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 48),
              // Clean loader spinning in university blue
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(BUColors.primaryBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


