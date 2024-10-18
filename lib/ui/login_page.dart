import 'package:flutter/material.dart';
import 'package:jadwal_keberangkatan/bloc/login_bloc.dart';
import 'package:jadwal_keberangkatan/helper/user_info.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_page.dart';
import 'package:jadwal_keberangkatan/ui/register_page.dart';
import 'package:jadwal_keberangkatan/widget/success_dialog.dart';
import 'package:jadwal_keberangkatan/widget/warning_dialog.dart';

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
    backgroundColor: Colors.yellow,
		title: const Text(
      'Login ',
      style : TextStyle(fontFamily: 'Helvetica'),
      ),
	  ),
      body: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.yellow[100], // Set your desired background color here
      child: SingleChildScrollView(
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
        Row(
          children: [
            Text("Belum punya akun? "),
            _menuRegistrasi(),
          ],
        )
			  ],
			),
		  ),
		),
	  ),)
	);
  }

  // Membuat Textbox email
  Widget _emailTextField() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
	  decoration: const InputDecoration(labelText: "Email"),
	  keyboardType: TextInputType.emailAddress,
	  controller: _emailTextboxController,
	  validator: (value) {
		// validasi harus diisi
		if (value!.isEmpty) {
		  return 'Email harus diisi';
		}
		return null;
	  },)
	);
  }

  // Membuat Textbox password
  Widget _passwordTextField() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10.0),
    child: TextFormField(
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
	  },)
	);
  }

  // Membuat Tombol Login
  Widget _buttonLogin() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
     backgroundColor: Colors.yellow[50],
    ),
	  child: const Text("Login"),
	  onPressed: () {
		var validasi = _formKey.currentState!.validate();
    if (validasi) {
      if (!isLoading) {
        _submit();
      }
    }
	  },
	);
  }

void _submit() {
  _formKey.currentState!.save();
  setState(() {
    isLoading = true;
  });
  LoginBloc.login(
    email: _emailTextboxController.text,
    password: _passwordTextboxController.text,
  ).then((value) async {
    if (value.code == 200) {
      await UserInfo().setToken(value.token.toString());
      await UserInfo().setUserId(value.userId!);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const SuccessDialog(
          description: "Login berhasil",
        ),
      ).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const JadwalPage()),
        );
      }
      );
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    }
  }, onError: (error) {
    print(error);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const WarningDialog(
        description: "Login gagal, silahkan coba lagi",
      ),
    );
  });
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