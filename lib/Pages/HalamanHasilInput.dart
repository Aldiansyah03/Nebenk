import 'package:flutter/material.dart';
import 'package:nebengk/Pages/Beritumpangan1.dart';

class BeriTumpangan extends StatefulWidget {
  @override
  _BeriTumpanganState createState() => _BeriTumpanganState();
}

class _BeriTumpanganState extends State<BeriTumpangan> {
  String selectedVehicleType = "Mobil"; // Variabel untuk jenis kendaraan
  int selectedSeatCount = 2; // Variabel untuk jumlah kursi

  TextEditingController biayaPerjalananController = TextEditingController();
  TextEditingController detailPerjalananController = TextEditingController();
  TextEditingController batasWaktuPemesananController = TextEditingController();

  DateTime selectedDate = DateTime.now(); // Variabel untuk tanggal perjalanan
  TimeOfDay selectedTime = TimeOfDay.now(); // Variabel untuk jam keberangkatan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: Color(0xFF3668B2),
        title: Text("Buat Perjalanan"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Implementasi tindakan ketika tombol pesan ditekan
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: selectedVehicleType,
                      items: ["Mobil", "Motor"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedVehicleType = newValue!;
                          if (selectedVehicleType == "Motor") {
                            selectedSeatCount = 1;
                          } else {
                            selectedSeatCount = 2;
                          }
                        });
                      },
                      decoration: InputDecoration(labelText: 'Jenis Kendaraan'),
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<int>(
                      value: selectedSeatCount,
                      items: (selectedVehicleType == "Mobil")
                          ? [2, 3, 4].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value kursi'),
                              );
                            }).toList()
                          : [1].map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text('$value kursi'),
                              );
                            }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedSeatCount = newValue!;
                        });
                      },
                      decoration: InputDecoration(labelText: 'Jumlah Kursi'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: biayaPerjalananController,
                      decoration: InputDecoration(labelText: 'Keterangan kendaraan'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: batasWaktuPemesananController,
                      decoration: InputDecoration(labelText: 'Biaya patungan/orang'),
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: detailPerjalananController,
                      decoration: InputDecoration(labelText: 'Detail Perjalanan'),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 10),
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.edit), // Ikona edit jika pengguna ingin mengubah tanggal
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (pickedTime != null && pickedTime != selectedTime) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 10),
                          Text(
                            selectedTime.format(context),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.edit), // Ikona edit jika pengguna ingin mengubah jam
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final snackBar = SnackBar(
                          content: Text('Perjalanan Berhasil dibuat. Silahkan tunggu untuk pengajuan dari pengguna lain.'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Beritumpangan1(
                              jenisKendaraan: selectedVehicleType,
                              jumlahKursi: selectedSeatCount.toString(),
                              biayaPerjalanan: biayaPerjalananController.text,
                              detailPerjalanan: detailPerjalananController.text,
                              batasWaktuPemesanan: batasWaktuPemesananController.text,
                              tanggalPerjalanan: "${selectedDate.toLocal()}".split(' ')[0], // Tanggal perjalanan
                              jamKeberangkatan: selectedTime.format(context), // Jam keberangkatan
                            ),
                          ),
                        );
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
