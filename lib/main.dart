import 'package:flutter/material.dart';
import 'webview_screen.dart';

void main() {
  runApp(const BUGatewayApp());
}

class BUGatewayApp extends StatelessWidget {
  const BUGatewayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BU Gateway',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'BU Gateway',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003087),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            _buildServiceCard(context, 'Official Website', '🏫', 'https://bugemauniv.ac.ug/'),
            _buildServiceCard(context, 'Student Portal (ERMS)', '🎓', 'https://erms.bugemauniv.ac.ug/student/login/'),
            _buildServiceCard(context, 'Staff Portal', '👨‍🏫', 'https://erms.bugemauniv.ac.ug/staff/login/'),
            _buildServiceCard(context, 'E-Learning (ODeL)', '📚', 'https://elearning.bugemauniv.ac.ug/'),
            _buildServiceCard(context, 'Online Payments', '💳', 'https://payments.bugemauniv.ac.ug/payments/'),
            _buildServiceCard(context, 'Payment Status', '🧾', 'https://payments.bugemauniv.ac.ug/payments/status/'),
            _buildServiceCard(context, 'E-Library', '📖', 'http://lib.bugemauniv.ac.ug'),
            _buildServiceCard(context, 'Library Catalog', '🔍', 'https://koha.bugemauniv.ac.ug'),
            _buildServiceCard(context, 'Institutional Repository (BUIR)', '🗄️', 'https://buir.bugemauniv.ac.ug/xmlui/'),
            _buildServiceCard(context, 'Scholarly Journals (OJS)', '📰', 'https://journal.bugemauniv.ac.ug/'),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, String emoji, String url) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFF003087).withValues(alpha: 0.1),
          child: Text(emoji, style: const TextStyle(fontSize: 26)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15.5)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF003087)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(title: title, url: url),
            ),
          );
        },
      ),
    );
  }
}