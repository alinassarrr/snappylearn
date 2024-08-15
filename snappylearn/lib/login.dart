import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'majors.dart';

const String _baseURL = 'https://snappylearn.000webhostapp.com';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyAppState();
}

class _MyAppState extends State<LoginPage> {
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
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Please enter your username and password',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: username,
                          decoration: _buildInputDecoration('Username', Icons.person),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter a valid username' : null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          controller: password,
                          decoration: _buildInputDecoration('Password', Icons.lock),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty ? 'Please enter a valid password' : null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _loading ? null : _login,
                          child: _loading
                              ? CircularProgressIndicator()
                              : const Text('Login', style: TextStyle(color: Colors.white)),
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
                            // Add your forget password logic here
                          },
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        )
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

  void _login() async {
  setState(() {
    _loading = true;
  });

  try {
    final response = await http.post(
      Uri.parse('$_baseURL/login.php'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username.text,
        'password': password.text,
      }),
    ).timeout(const Duration(seconds: 8));

    if (response.statusCode == 200) {
      List<dynamic> userData = jsonDecode(response.body);
      if (userData.isNotEmpty) {
        String userId = userData[0]['id'].toString();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Majors(userId: userId,),
          ),
        );
      } else {
        _showErrorDialog('Invalid username or password');
      }
    } else {
      _showErrorDialog('Error during login. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error during login: $e');
    _showErrorDialog('Error during login. Check console for details: $e');
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
          title: Text('Login Error'),
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
