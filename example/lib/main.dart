import 'package:flutter/material.dart';
import 'package:xecosystem/xecosystem.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  XApi.init(baseUrl: "https://jsonplaceholder.typicode.com");
  XApi.addInspector([PrettyDioLogger()]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: XTheme.light(),
      home: const LoginScreen(),
    );
  }
}

// ==================== LOGIN SCREEN ====================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController(text: "sagar@example.com");
  final passCtrl = TextEditingController(text: "password123");
  bool loading = false;

  Future<void> login() async {
    setState(() => loading = true);

    // Fake delay (real app me API call)
    await Future.delayed(const Duration(seconds: 2));

    setState(() => loading = false);

    // Navigate to dashboard
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return XScaffold(
      title: "Welcome Back",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo / Title
            const Icon(Icons.flutter_dash, size: 80, color: XTokens.primary),
            const SizedBox(height: 32),

            XText(
              "Login to xecosystem",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 48),

            // Email
            XInput(label: "Email", controller: emailCtrl),
            const SizedBox(height: 16),

            // Password
            XInput(label: "Password", controller: passCtrl),
            const SizedBox(height: 32),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: XButton(
                text: "Login",
                loading: loading,
                onPressed: loading ? null : login,
              ),
            ),

            const SizedBox(height: 24),
            XText(
              "Demo app • Indore se ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== DASHBOARD SCREEN ====================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return XScaffold(
      title: "Dashboard",
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            XText(
              "User Profile",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),

            XFutureBuilder<Map<String, dynamic>>(
              future: XApi.get<Map<String, dynamic>>("/users/2"),

              builder: (data) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(XTokens.radiusMd),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      XText(
                        "Name: ${data['name']}",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      XText("Username: ${data['username']}"),
                      const SizedBox(height: 12),
                      XText("Email: ${data['email']}"),
                      const SizedBox(height: 12),
                      XText("Phone: ${data['phone']}"),
                      const SizedBox(height: 12),
                      XText("Website: ${data['website']}"),
                      const SizedBox(height: 24),
                      XText("Company: ${data['company']['name']}"),
                      XText("Catch Phrase: ${data['company']['catchPhrase']}"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
