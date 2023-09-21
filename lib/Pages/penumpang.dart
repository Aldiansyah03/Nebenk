import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Penumpang extends StatelessWidget {
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
                        onTap: () {},
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
              // Daftar kotak dengan data
              Container(
                margin: EdgeInsets.all(15),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5, // Ganti dengan jumlah data yang sesuai
                  itemBuilder: (context, index) {
                    // Data palsu (ganti dengan data sesuai)
                    String tanggal = "01-09-2023";
                    String jam = "08:00 AM";
                    int jumlahKursi = 3;
                    String lokasi = "ITK";
                    String pemberiTumpangan = "John Doe";

                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Tanggal: $tanggal"),
                          Text("Jam: $jam"),
                          Text("Jumlah Kursi: $jumlahKursi"),
                          Text("Lokasi: $lokasi"),
                          Text("Pemberi Tumpangan: $pemberiTumpangan"),
                          SizedBox(height: 10),
                          // Menggunakan ikon mobil
                          Icon(
                            Icons.directions_car,
                            size: 80,
                            color: Colors.blue, // Ganti dengan warna yang sesuai
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}