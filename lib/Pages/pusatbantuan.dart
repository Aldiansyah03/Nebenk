import 'package:flutter/material.dart';

class PusatBantuan extends StatefulWidget {
  const PusatBantuan({super.key});

  @override
  _PusatBantuanState createState() => _PusatBantuanState();
}

class _PusatBantuanState extends State<PusatBantuan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
        backgroundColor: const Color(0xFF3668B2),
      ),
      body: const PusatBantuanScreen(),
    );
  }
}

class PusatBantuanScreen extends StatelessWidget {
  const PusatBantuanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Text(
              '''Selamat Datang di Pusat Bantuan NeBengK! Kami disini untuk membantu anda memahami dan memaksimalkan pengalaman anda menggunakan aplikasi NeBengK. Silahkan temukan informasi yang anda butuhkan di bawah ini atau hubungi tim pendukung pelanggan kami jika anda memiliki pertanyaan yang tidak terjawab.''',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        PusatBantuanExpansionTile(
          title: '1. Panduan Pengguna',
          content: '''
1. Mencari Tumpangan
      Setelah masuk ke dalam Aplikasi silahkan piih menu mencari tumpangan. Anda akan diminta untuk memasukan titik lokasi. Setelah itu anda bisa memilih tumpangan yang anda inginkan seusi dengan kebutuhan anda dan bisa melihat detail dari perjalanan yang ditawarkan pengguna lain. Silahkan klik tombol pesan dan tunggu konfirmasi dari pemberi tumpangan.
2. Menawarkan Tumpangan
      Setelah msauk ke dalam aplikasi silahkan pilih menu menawarkan tumpangan. Kemudian pilih titik awal perjalanan anda. Silahkan isi detail dari perjalanan yang anda tawarkan, kemudian tunggu pengguna lain mengajukan tawaran. Anda bisa menonfirmasi pengajuan tawaran dari pengguna lain hingga batas waktu yang anda tentukan yang bisa anda tolak atau anda terima''',
        ),
        PusatBantuanExpansionTile(
          title: '2. FAQ',
          content: '''
1. Apakah saya perlu membayar untuk menggunakan aplikasi ini?
      Penggunaan dasar aplikasi "Nebengk" adalah gratis. Namun, biaya mungkin dikenakan oleh pengemudi jika anda memesan tumpangan. Biaya ini akan ditampilkan sebelum anda memutuskan untuk memilih tumpangan.
2. Bagaimana saya dapat menghubungi pengemudi atau penumpang setelah memesan tumpangan?
      Setelah memesan tumpangan, anda dapat menghubungi pengemudi atau penumpang melalui fitur obrolan dalam aplikasi kami atau bisa langsung menghubungi melalui nomor Telepon untuk detail titik pertemuan dengan pengguna lain.
3. Bagaimana cara mengubah atau membatalkan pesanan saya?
      Anda dapat mengubah atau membatalkan pesanan anda melalui menu pesanan saya. Anda dapat mengubah atau membatalkan pesanan anda sebelum pengemudi atau penumpang mengkonfirmasi pesanan anda.
4. Apakah aplikasi ini aman digunakan?
      Kami melakukan yang terbaik untuk memastikan bahwa aplikasi kami aman untuk digunakan. Kami melakukan verifikasi pengemudi dan penumpang untuk memastikan bahwa mereka adalah orang yang mereka katakan.
5. Bagaimana cara saya menilai dan memberikan ulasan setelah perjalanan selesai?
      Anda dapat menilai dan memberikan ulasan setelah perjalanan selesai melalui menu pesanan saya. Anda dapat menilai dan memberikan ulasan setelah perjalanan selesai. Ulasan dari anda akan membantu pengguna lain untuk memilih pengemudi atau penumpang yang tepat.
      ''',
        ),
        PusatBantuanExpansionTile(
          title: '3. Solusi Masalah Umum',
          content: '''
1. Tidak bisa menemukan tumpangan:
      Coba lagi beberapa saat kemudian, mungkin ada pengemudi lain yang akan menawarkan tumpangan.
''',
        ),
        PusatBantuanExpansionTile(
          title: '4. Dukungan Pelanggan',
          content: '''
Kami selalu siap membantu anda dengan pertanyaan, maslaah, atau pertimbangan apapun yang anda miliki.

Silahkan Hubungi kami di:
- Email Dukungan Pelanggan : nebenk@gmail.com
- Telepon Dukungan Pelanggan : 085266127946

Jam Operasional Dukungan Pelanggan
Senin - Jumat : 08.00 - 17.00 WIB
Sabtu : 08.00 - 12.00 WIB 
''',
        ),
      ],
    );
  }
}

class PusatBantuanExpansionTile extends StatelessWidget {
  final String title;
  final String content;

  const PusatBantuanExpansionTile({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
