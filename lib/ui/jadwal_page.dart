import 'package:flutter/material.dart';
import 'package:jadwal_keberangkatan/bloc/logout_bloc.dart';
import 'package:jadwal_keberangkatan/bloc/jadwal_bloc.dart';
import 'package:jadwal_keberangkatan/model/jadwal.dart';
import 'package:jadwal_keberangkatan/ui/login_page.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_detail.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_form.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  _JadwalPageState createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Jadwal Keberangkatan'),
        backgroundColor: Colors.yellow,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26),
              onTap: () async {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => JadwalForm())
                );
              },
            )
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false)
                    });
              },
            ),
          ],
        ),
      ),
      body: 
        Container(
          color: Colors.yellow[100],
          child: FutureBuilder<List<Jadwal>>(
            future: JadwalBloc.getJadwal(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData?
                ListJadwal(
                  list : snapshot.data,
                ) : const Center(
                  child: CircularProgressIndicator(),
                );
            },
          ),
        ),
      );
  }
}

class ListJadwal extends StatelessWidget {
  final List? list;

  const ListJadwal({super.key, required this.list});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, index) {
        return ItemJadwal(jadwal: list![index]);
      },
    );
  }
}

class ItemJadwal extends StatelessWidget {
  final Jadwal jadwal;

  const ItemJadwal({super.key, required this.jadwal});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JadwalDetail(jadwal: jadwal))
        );
      },
      child: Card(
        color: Colors.yellow[50],
        child: ListTile(
          title: Text(jadwal.route!),
          subtitle: Text(jadwal.transport!),
          leading: Text(jadwal.frequency.toString()),
        ),
      ),
    );
  }
}