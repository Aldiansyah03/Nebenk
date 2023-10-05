import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/PemesananKursiPage.dart';

class Penumpang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("NeBengK"),
        actions: [
          IconButton(
            icon: Icon(Icons.person), // Mengganti ikon person menjadi ikon chat
            onPressed: () {
              // Implementasi tindakan ketika tombol chat ditekan
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Spasi antara header dan pencarian

              // Widget Pencarian
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Telusuri ...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20), // Spasi antara pencarian dan daftar perjalanan
              Container(
                margin: EdgeInsets.all(15),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // Gantilah data berikut dengan data yang sesuai dari daftar perjalanan
                    String tanggal = "01-09-2023";
                    String jam = "08:00 AM";
                    int jumlahKursi = 3;
                    String lokasi = "ITK";
                    String pemberiTumpangan = "John Doe";

                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke halaman rinci dengan data yang sesuai
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PemesananKursiPage(
                              tanggal: tanggal,
                              jam: jam,
                              jumlahKursi: jumlahKursi,
                              lokasi: lokasi,
                              pemberiTumpangan: pemberiTumpangan,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2, // Efek elevasi untuk card
                        child: ListTile(
                          leading: Icon(
                            Icons.directions_car,
                            size: 50,
                            color: Colors.blue, // Ganti dengan warna yang sesuai
                          ),
                          title: Text("Lokasi: $lokasi"),
                          subtitle: Text("Tanggal: $tanggal\nJam: $jam\nJumlah Kursi: $jumlahKursi\nPemberi Tumpangan: $pemberiTumpangan"),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
