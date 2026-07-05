import 'package:flutter/material.dart';

void main() {
  // This is the entry point of the entire application
  runApp(const BUGatewayApp());
}

/// This is the root widget of the BU Gateway application.
/// It sets up the overall theme and navigation.
class BUGatewayApp extends StatelessWidget {
  const BUGatewayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BU Gateway',
      debugShowCheckedModeBanner: false, // Hides the "DEBUG" banner
      // Theme configuration using Bugema University official colors
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Light gray background
      ),
      home: const HomeScreen(), // The first screen users see
    );
  }
}

/// HomeScreen is the main dashboard of the app.
/// It contains the university branding and quick access to all platforms.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('BU Gateway', style: TextStyle(fontWeight: FontWeight.w600, color: Color.fromARGB(255, 255, 255, 255), )),
        backgroundColor: const Color(0xFF003087), // Bugema Blue
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // University Branding Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF003087),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Icon(Icons.school, size: 48, color: Colors.white),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to BU Gateway',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Bugema University',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Section title
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Access all university digital platforms in one place',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // List of all university platforms
            _buildServiceCard('Official Website', '🏫', 'https://bugemauniv.ac.ug/'),
            _buildServiceCard('Student Portal (ERMS)', '🎓', 'https://erms.bugemauniv.ac.ug/student/login/'),
            _buildServiceCard('Staff Portal', '👨‍🏫', 'https://erms.bugemauniv.ac.ug/staff/login/'),
            _buildServiceCard('E-Learning (ODeL)', '📚', 'https://elearning.bugemauniv.ac.ug/'),
            _buildServiceCard('Online Payments', '💳', 'https://payments.bugemauniv.ac.ug/payments/'),
            _buildServiceCard('Payment Status', '🧾', 'https://payments.bugemauniv.ac.ug/payments/status/'),
            _buildServiceCard('E-Library', '📖', 'http://lib.bugemauniv.ac.ug'),
            _buildServiceCard('Library Catalog', '🔍', 'https://koha.bugemauniv.ac.ug'),
            _buildServiceCard('Institutional Repository (BUIR)', '🗄️', 'https://buir.bugemauniv.ac.ug/xmlui/'),
            _buildServiceCard('Scholarly Journals (OJS)', '📰', 'https://journal.bugemauniv.ac.ug/'),
          ],
        ),
      ),
    );
  }

  /// Reusable component to create a service card
  /// Parameters:
  /// - title: Name of the platform
  /// - emoji: Visual icon
  /// - url: Link to the platform
  Widget _buildServiceCard(String title, String emoji, String url) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF003087).withOpacity(0.1),
          child: Text(emoji, style: const TextStyle(fontSize: 26)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF003087)),
        onTap: () {
          // TODO: In future we will open the URL in the browser
          print('User clicked: $title -> $url');
        },
      ),
    );
  }
}