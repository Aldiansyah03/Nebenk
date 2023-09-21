import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BeriTumpangan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 20, left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 30,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "NeBengK",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          // Aksi ketika ikon profil ditekan
                        },
                        child: Icon(
                          CupertinoIcons.person,
                          size: 30,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Spasi antara header dan form

              // Form untuk memasukkan data perjalanan
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Jenis Kendaraan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Jumlah Kursi'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Biaya Perjalanan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Detail Perjalanan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Batas Waktu Pemesanan'),
                    ),
                    SizedBox(height: 20),

                    // Tombol "Buat Perjalanan"
                    ElevatedButton(
                      onPressed: () {
                        // Tampilkan pemberitahuan
                        final snackBar = SnackBar(
                          content: Text('Perjalanan Berhasil dibuat. Silahkan tunggu untuk pengajuan dari pengguna lain.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        // Berpindah ke halaman baru (ganti dengan nama yang sesuai)
                    
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF49648D),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          'Buat perjalanan',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
