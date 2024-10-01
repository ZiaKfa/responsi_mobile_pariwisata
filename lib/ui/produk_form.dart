import 'package:flutter/material.dart';
import 'package:toko_kita/model/produk.dart';

class ProdukForm extends StatefulWidget {
  Produk? produk;
  ProdukForm({super.key, this.produk});


  @override
  _ProdukFormState createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final _formKey = GlobalKey<FormState>();
  final bool _isLoading = false;
  String judul = "Tambah Produk Zia";
  String tombolSubmit = "Simpan";

  final _kodeProdukTextController = TextEditingController();
  final _namaProdukTextController = TextEditingController();
  final _hargaProdukTextController = TextEditingController();

  @override
  void initState(){
    super.initState();
    isUpdate();
  }

    isUpdate(){
    if(widget.produk != null){
      judul = "Ubah Produk Zia";
      tombolSubmit = "Ubah";
      _kodeProdukTextController.text = widget.produk!.kodeProduk!;
      _namaProdukTextController.text = widget.produk!.namaProduk!;
      _hargaProdukTextController.text = widget.produk!.hargaProduk.toString();
    } else {
      judul = "Tambah Produk Zia";
      tombolSubmit = "Simpan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _kodeProdukTextField(),
                _namaProdukTextField(),
                _hargaProdukTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _kodeProdukTextField(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Kode Produk'),
      keyboardType: TextInputType.text,
      controller: _kodeProdukTextController,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Kode Produk tidak boleh kosong';
        }
        return null;
      },
    );  
  }

  Widget _namaProdukTextField(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Nama Produk'),
      keyboardType: TextInputType.text,
      controller: _namaProdukTextController,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Nama Produk tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _hargaProdukTextField(){
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Harga Produk'),
      keyboardType: TextInputType.number,
      controller: _hargaProdukTextController,
      validator: (value){
        if(value == null || value.isEmpty){
          return 'Harga Produk tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit(){
    return OutlinedButton(onPressed: (){
      var validasi = _formKey.currentState!.validate();
    }
    
    , child: Text(tombolSubmit));
  }
}
