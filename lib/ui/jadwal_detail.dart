import 'package:flutter/material.dart';
import 'package:jadwal_keberangkatan/bloc/jadwal_bloc.dart';
import 'package:jadwal_keberangkatan/model/jadwal.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_form.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_page.dart';
import 'package:jadwal_keberangkatan/widget/success_dialog.dart';
import 'package:jadwal_keberangkatan/widget/warning_dialog.dart';

class JadwalDetail extends StatefulWidget {
  final Jadwal? jadwal;

  const JadwalDetail({super.key, this.jadwal});

  @override
  _JadwalDetailState createState() => _JadwalDetailState();
}

class _JadwalDetailState extends State<JadwalDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Jadwal ${widget.jadwal?.route}'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
          child: Text(
            'Detail Jadwal',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
            ),
            SizedBox(height: 20),
            Text(
          'Transportasi: ${widget.jadwal?.transport}',
          style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
          'Rute: ${widget.jadwal?.route}',
          style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
          'Frekuensi: ${widget.jadwal?.frequency}',
          style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Center(child: _tombolAksi()),
          ],
        ),
          ),
        ),
      ),
    );
  }

  Widget _tombolAksi() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          child: const Text('Edit'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JadwalForm(jadwal: widget.jadwal),
              ),
            );
          },
        ),
        OutlinedButton(
          child: const Text('Hapus'),
          onPressed: () {
            konfirmasiHapus();
          },
        ),
      ],
    );
  }

  void konfirmasiHapus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            OutlinedButton(
              onPressed: () {
                JadwalBloc.deleteJadwal(id: widget.jadwal!.id!).then(
                  (value) => {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const SuccessDialog(
                        description: "Hapus berhasil",
                      ),
                    ).then((value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const JadwalPage()),
                      );
                    }),
                  },
                  onError: (error) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ),
                    );
                  },
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
        
      },
    );
  }
}