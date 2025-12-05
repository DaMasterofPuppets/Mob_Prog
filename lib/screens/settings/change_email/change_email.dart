import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditEmailPage extends StatefulWidget {
  const EditEmailPage({super.key});

  @override
  State<EditEmailPage> createState() => _EditEmailPageState();
}

class _EditEmailPageState extends State<EditEmailPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;

  SupabaseClient get supabase => Supabase.instance.client;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  //  UNIVERSAL POPUP (your exact design)
  // ---------------------------------------------------------------------------
  void _showPopup(String title, String message) {
    const Color accent = Color(0xFFE1A948);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          decoration: BoxDecoration(
            color: const Color(0xFF450003),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: accent, width: 3.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 64,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE1A948),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: accent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: accent),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Error popup shortcut
  void _showError(String msg) {
    _showPopup("Error", msg);
  }

  // Success popup shortcut
  void _showSuccess(String msg) {
    _showPopup("Check Your Email", msg);
  }

  // ---------------------------------------------------------------------------
  //  CHANGE EMAIL LOGIC
  // ---------------------------------------------------------------------------
  Future<void> _changeEmail() async {
    final newEmail = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (newEmail.isEmpty || password.isEmpty) {
      return _showError("Fill in all fields.");
    }

    setState(() => _loading = true);

    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        _showError("Not logged in.");
        return;
      }

      await supabase.auth.signInWithPassword(
        email: user.email!,
        password: password,
      );

      await supabase.auth.updateUser(
        UserAttributes(email: newEmail),
      );

      if (!mounted) return;

      _showSuccess(
        "A confirmation link was sent to:\n\n$newEmail\n\n"
        "Open it to finish updating your email.",
      );

      _emailController.clear();
      _passwordController.clear();
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError("Something went wrong.");
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ---------------------------------------------------------------------------
  // UI
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final currentEmail = supabase.auth.currentUser?.email ?? "Unknown";

    return Scaffold(
      backgroundColor: const Color(0xFF420309),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 34, right: 34, bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    const Center(
                      child: Text(
                        'Edit: Email',
                        style: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 30,
                          color: Color(0xFFE1A948),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: Image.asset('assets/images/logo.png', height: 130),
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A0A07),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Center(
                        child: Text(
                          "Current Email:\n$currentEmail",
                          style: const TextStyle(
                            fontFamily: 'PlayfairDisplay',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter New Email",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: _loading ? null : _changeEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE1A948),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _loading ? "PROCESSING..." : "NEXT",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Fixed back button
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFE1A948)),
                onPressed: () => Navigator.pop(context),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(12),
                  fixedSize: const Size(48, 48),
                ),
              ),
            ),

            if (_loading)
              Container(
                color: Colors.black.withOpacity(0.3),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
