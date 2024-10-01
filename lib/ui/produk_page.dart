import 'package:flutter/material.dart';
import 'package:toko_kita/model/produk.dart';
import 'package:toko_kita/ui/produk_detail.dart';
import 'package:toko_kita/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Produk Zia'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26),
              onTap: () async {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ProdukForm())
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
                
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ItemProduk(
            produk: Produk(
              id: 1,
              kodeProduk: 'A001',
              namaProduk: 'Kamera',
              harga: 10000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: 2,
              kodeProduk: 'P002',
              namaProduk: 'Kulkas',
              harga: 20000,
            ),
          ),
          ItemProduk(
            produk: Produk(
              id: 3,
              kodeProduk: 'P003',
              namaProduk: 'Mesin Cuci',
              harga: 30000,
            ),
          ),
        ],
      )
      );
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  const ItemProduk({super.key, required this.produk});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProdukDetail(produk: produk))
        );
      },
      child: Card(
        child: ListTile(
          title: Text(produk.namaProduk!),
          subtitle: Text(produk.harga.toString()),
        ),
      ),
    );
  }
}