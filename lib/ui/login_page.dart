import 'package:flutter/material.dart';
import 'package:toko_kita/ui/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _emailTextboxController = TextEditingController();
  final TextEditingController _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
	return Scaffold(
	  appBar: AppBar(
		title: const Text('Login'),
	  ),
	  body: SingleChildScrollView(
		child: Padding(
		  padding: const EdgeInsets.all(8.0),
		  child: Form(
			key: _formKey,
			child: Column(
			  children: [
				_emailTextField(),
				_passwordTextField(),
				_buttonLogin(),
				const SizedBox(height: 30),
				_menuRegistrasi(),
			  ],
			),
		  ),
		),
	  ),
	);
  }

  // Membuat Textbox email
  Widget _emailTextField() {
	return TextFormField(
	  decoration: const InputDecoration(labelText: "Email"),
	  keyboardType: TextInputType.emailAddress,
	  controller: _emailTextboxController,
	  validator: (value) {
		// validasi harus diisi
		if (value!.isEmpty) {
		  return 'Email harus diisi';
		}
		return null;
	  },
	);
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
	return TextFormField(
	  decoration: const InputDecoration(labelText: "Password"),
	  keyboardType: TextInputType.text,
	  obscureText: true,
	  controller: _passwordTextboxController,
	  validator: (value) {
		// jika karakter yang dimasukkan kurang dari 6 karakter
		if (value!.isEmpty) {
		  return "Password harus diisi";
		}
		return null;
	  },
	);
  }

  // Membuat Tombol Login
  Widget _buttonLogin() {
	return ElevatedButton(
	  child: const Text("Login"),
	  onPressed: () {
		var validasi = _formKey.currentState!.validate();
	  },
	);
  }

  // Membuat Menu Registrasi
  Widget _menuRegistrasi() {
	return Center(
    child: InkWell(
      child: const Text(
        'Registrasi',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
      },
    )
  );
  }
}