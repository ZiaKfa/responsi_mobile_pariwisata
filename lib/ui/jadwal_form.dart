import 'package:flutter/material.dart';
import 'package:jadwal_keberangkatan/bloc/jadwal_bloc.dart';
import 'package:jadwal_keberangkatan/model/jadwal.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_page.dart';
import 'package:jadwal_keberangkatan/widget/success_dialog.dart';
import 'package:jadwal_keberangkatan/widget/warning_dialog.dart';

class JadwalForm extends StatefulWidget {
  final Jadwal? jadwal;
  const JadwalForm({super.key, this.jadwal});

  @override
  _JadwalFormState createState() => _JadwalFormState();
}

class _JadwalFormState extends State<JadwalForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _transportTextController = TextEditingController();
  final TextEditingController _routeTextController = TextEditingController();
  final TextEditingController _frequencyJadwalTextController = TextEditingController();
  

  String judul = "Tambah Jadwal Zia";
  String tombolSubmit = "Simpan";


  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.jadwal != null) {
      judul = "Ubah Jadwal Keberangkatan";
      tombolSubmit = "Ubah";
      _transportTextController.text = widget.jadwal!.transport!;
      _routeTextController.text = widget.jadwal!.route!;
      _frequencyJadwalTextController.text = widget.jadwal!.frequency.toString();
  
    } else {
      judul = "Tambah Jadwal Keberangkatan";
      tombolSubmit = "Simpan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _transportTextField(),
                _routeTextField(),
                _frequencyJadwalTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _transportTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
      decoration: const InputDecoration(labelText: 'Moda transportasi'),
      keyboardType: TextInputType.text,
      controller: _transportTextController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Moda transportasi tidak boleh kosong';
        }
        return null;
      },
    ));
  }

  Widget _routeTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Rute keberangkatan'),
        keyboardType: TextInputType.text,
        controller: _routeTextController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Rute keberangkatan tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }

  Widget _frequencyJadwalTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: const InputDecoration(labelText: 'Frekuensi'),
        keyboardType: TextInputType.number,
        controller: _frequencyJadwalTextController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Frekuensi tidak boleh kosong';
          }
          return null;
        },
      ),
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
      backgroundColor: Colors.yellow[100],
      ),
      child: Text(tombolSubmit),
      
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.jadwal != null) {
              // kondisi update jadwal
              ubah();
            } else {
              // kondisi tambah jadwal
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Jadwal createJadwal = Jadwal(id: null);
    createJadwal.transport = _transportTextController.text;
    createJadwal.route = _routeTextController.text;
    createJadwal.frequency = (_frequencyJadwalTextController.text);
    print(createJadwal.frequency);
    print(createJadwal.route);
    print(createJadwal.transport);
    JadwalBloc.addJadwal(jadwal: createJadwal).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const SuccessDialog(
          description: "Data berhasil disimpan",
        )
      ).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const JadwalPage(),
        ));
      });
    }, onError: (error) {
      print(error);
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Jadwal updateJadwal = Jadwal(id: widget.jadwal!.id!);
    updateJadwal.transport = _transportTextController.text;
    updateJadwal.route = _routeTextController.text;
    updateJadwal.frequency = (_frequencyJadwalTextController.text);
    JadwalBloc.updateJadwal(jadwal: updateJadwal).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const SuccessDialog(
          description: "Data berhasil diubah",
        ),
      ).then((value) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const JadwalPage(),
        ));
      }
      );
    }, onError: (error) {
      print(error);
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
