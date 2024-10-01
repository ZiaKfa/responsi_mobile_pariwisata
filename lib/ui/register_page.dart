import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>(); 
  final bool _isLoading = false;

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _namaTextField(),
                _emailTextField(),
                _passwordTextField(),
                _konfirmasiPaswordTextField(),
                _registerButton(),
              ],
            ),
          )
        )
      ),
    );
  }

  Widget _namaTextField(){
    return TextFormField(
      controller: _namaController,
      decoration: const InputDecoration(
        labelText: 'Nama',
        hintText: 'Masukkan Nama Anda',
      ),
      keyboardType: TextInputType.text,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Nama tidak boleh kosong';
        } else if(value.length < 3){
          return 'Nama minimal 3 karakter';
        }
        return null;
      },
    );
  }

  Widget _emailTextField(){
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Masukkan Email Anda',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Email tidak boleh kosong';
        } 
        Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0 -9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zAZ]{2,}))$';
        RegExp regex = RegExp(pattern.toString());
        if(!regex.hasMatch(value)){
          return 'Email tidak valid';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField(){
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Masukkan Password Anda',
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Password tidak boleh kosong';
        } else if(value.length < 6){
          return 'Password minimal 6 karakter';
        }
        return null;
      },
    );
  }
  Widget _konfirmasiPaswordTextField(){
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Konfirmasi Password',
        hintText: 'Masukkan Konfirmasi Password Anda',
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Konfirmasi Password tidak boleh kosong';
        } else if(value != _passwordController.text){
          return 'Konfirmasi Password tidak sama';
        }
        return null;
      },
    );
  }

  Widget _registerButton(){
    return ElevatedButton(
      child: const Text('Registrasi'),
      onPressed: (){
        var validate = _formKey.currentState!.validate();
      });
  }
}
