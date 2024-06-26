import 'package:flutter/material.dart';
import 'package:task_app/data/user_data.dart';
import 'package:task_app/dio_data/book_api_call.dart';
import 'package:task_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late DatabaseHelper databaseHelper;
  final _form = GlobalKey<FormState>();
  var _enteredEmail = '';
  var _enteredPassword = '';

  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper(); // Initialize databaseHelper
  }

  @override
  void dispose() {
    _form.currentState?.dispose();
    super.dispose();
  }

  void scaffoldErrorMess(BuildContext context){
	ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          duration: Duration(seconds: 3),
        ),
      );
}

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    _form.currentState!.save();

    final isAuthentic =
        await databaseHelper.authenticateUser(_enteredEmail, _enteredPassword);

    if (isAuthentic) {
      _form.currentState?.reset();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => 
              const ApiCall(),
        ),
      );
    } else {
      scaffoldErrorMess(context);
    }
  }

  void _signUpPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: const ValueKey('email_id'),
                    decoration:
                        const InputDecoration(labelText: 'Email address'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('pass'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _enteredPassword = value!;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        key: const ValueKey('login_button'),
                        onPressed: () {
                          _submit();
                        },
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        key: const ValueKey('signUp_button'),
                        onPressed: () {
                          _signUpPage();
                        },
                        child: const Text('SignUp'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
