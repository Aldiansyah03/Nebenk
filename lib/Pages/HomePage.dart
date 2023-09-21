import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/HalamanHasilInput.dart';
import 'package:nebengk/Pages/penumpang.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9), // Menggunakan format warna yang valid
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 20, left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row( // Menambahkan baris untuk ikon menu dan teks "NeBengK"
                      children: [
                        Icon(
                          Icons.menu,
                          color: Colors.black, // Menggunakan Colors.black untuk warna ikon
                          size: 30,
                        ),
                        SizedBox(width: 8), // Spasi antara ikon dan teks
                        Text(
                          "NeBengK",
                          style: TextStyle(
                            color: Colors.black, // Menggunakan Colors.black untuk warna teks
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
                            color: Colors.white.withOpacity(0.5), // Menggunakan warna yang valid
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.person, // Menggunakan CupertinoIcons untuk ikon profil
                          size: 30,
                          color: const Color.fromARGB(255, 0, 0, 0), // Menggunakan Colors.white untuk warna ikon
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Spasi antara header dan kotak-kotak baru
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BeriTumpangan()));
                  // Aksi yang ingin Anda lakukan saat kotak motor ditekan
                },
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.motorcycle,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Beri Tumpangan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Spasi antara kotak "Beri Tumpangan" dan "Penumpang"
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Penumpang()));
                  // Aksi yang ingin Anda lakukan saat kotak penumpang ditekan
                },
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Penumpang ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
