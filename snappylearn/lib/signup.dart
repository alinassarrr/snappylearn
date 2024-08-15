import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/login.dart';

const String _baseURL = 'https://snappylearn.000webhostapp.com';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://images.unsplash.com/photo-1593698054469-2bb6fdf4b512?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Please enter your details',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 130.0, 50.0, 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: username,
                          decoration:
                              _buildInputDecoration('Username', Icons.person),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter a valid username'
                                : null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: password,
                          decoration:
                              _buildInputDecoration('Password', Icons.lock),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty
                                ? 'Please enter a valid password'
                                : null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _loading ? null : _signUp,
                          child: _loading
                              ? CircularProgressIndicator()
                              : const Text('Sign Up',
                                  style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 153, 68, 65),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Already have an account? Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
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

  InputDecoration _buildInputDecoration(String labelText, IconData prefixIcon) {
    return InputDecoration(
      labelText: labelText,
      hintText: 'Enter $labelText',
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(prefixIcon, color: Colors.blueAccent),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  void _signUp() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await http
          .post(
            Uri.parse('$_baseURL/signup.php'),
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: jsonEncode({
              'username': username.text,
              'password': password.text,
            }),
          )
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('success')) {
          // Registration successful, navigate to LoginPage
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else if (responseData.containsKey('error')) {
          // Handle different error scenarios
          String errorMessage = responseData['error'];
          _showErrorDialog(errorMessage);
        } else {
          // Handle unexpected response
          _showErrorDialog('Unexpected response from server');
        }
      } else {
        print('HTTP error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        _showErrorDialog(
            'Error during signup. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during signup: $e');
      _showErrorDialog('Error during signup. Check console for details: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Signup Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
