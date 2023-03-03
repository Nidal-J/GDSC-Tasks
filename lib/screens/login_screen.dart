import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size(double.infinity, MediaQuery.of(context).size.height * 0.3),
        child: ClipPath(
          clipper: CurvedContainer(),
          child: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.3,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: const Text('Login', style: TextStyle(fontSize: 40)),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 0),
          children: [
            TextFormField(
              controller: emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required *';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'Enter Valid Email eg. ne@gu.pp';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_rounded),
                labelText: 'Email',
                filled: true,
                fillColor: Colors.grey[300],
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'This field is required *';
                } else if (value.length < 6) {
                  return 'Password must be 6 characters at least';
                }
                return null;
              },
              obscureText: !visible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_rounded),
                suffixIcon: IconButton(
                    onPressed: () {
                      visible = !visible;
                      setState(() {});
                    },
                    icon: visible
                        ? const Icon(Icons.visibility_rounded)
                        : const Icon(Icons.visibility_off_rounded)),
                labelText: 'Password',
                filled: true,
                fillColor: Colors.grey[300],
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  _performLogin();
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('logged in successfully'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class CurvedContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double h = size.height;
    double w = size.width;

    final path = Path();
    path.lineTo(0, h - 20);
    path.cubicTo(w * 0.33, h - 50, w * 0.7, h + 30, w, h - 20);
    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
