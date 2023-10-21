import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebengk/Pages/HalamanHasilInput.dart';
import 'package:nebengk/Pages/penumpang.dart';
import 'package:nebengk/Pages/profil.dart';
<<<<<<< HEAD
=======
import 'package:nebengk/Pages/pusatbantuan.dart';
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("NeBengK"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Implementasi tindakan ketika tombol pesan ditekan
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF3668B2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
<<<<<<< HEAD
                    child: Image.asset("assets/profil.png"),
=======
                    child: Image.asset("assets/icons/profil.png"),
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Aldiansyah',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Aldiansyah0302@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Akun'),
              onTap: () {
                // Navigate to the user profile page when "Akun" is tapped.
<<<<<<< HEAD
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
=======
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Pusat Bantuan'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Pusat Bantuan" diklik
<<<<<<< HEAD
=======
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PusatBantuan()));
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857
              },
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Dukungan'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Dukungan" diklik
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Aksi yang ingin Anda lakukan ketika "Logout" diklik
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ingin jadi apa anda hari ini?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
<<<<<<< HEAD
                Navigator.push(context, MaterialPageRoute(builder: (context) => BeriTumpangan()));
=======
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BeriTumpangan()));
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857
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
            SizedBox(height: 20),
            InkWell(
              onTap: () {
<<<<<<< HEAD
                Navigator.push(context, MaterialPageRoute(builder: (context) => Penumpang()));
=======
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Penumpang()));
>>>>>>> dd8aaa82aaeda1f9597ef96a5d8f9f6a44021857
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
    );
  }
}
