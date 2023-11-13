import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Trip {
  String user;
  String vehicleType;
  int seatCount;
  String cost;
  String details;
  String deadline;
  String date;
  String time;

  Trip({
    required this.user,
    required this.vehicleType,
    required this.seatCount,
    required this.cost,
    required this.details,
    required this.deadline,
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'vehicleType': vehicleType,
      'seatCount': seatCount,
      'cost': cost,
      'details': details,
      'deadline': deadline,
      'date': date,
      'time': time,
    };
  }
}

class BeriTumpangan extends StatefulWidget {
  @override
  _BeriTumpanganState createState() => _BeriTumpanganState();
}

class _BeriTumpanganState extends State<BeriTumpangan> {
  String selectedVehicleType = "Mobil";
  int selectedSeatCount = 2;

  TextEditingController namapemberitumpanganController =
      TextEditingController();
  TextEditingController biayaPerjalananController = TextEditingController();
  TextEditingController detailPerjalananController = TextEditingController();
  TextEditingController batasWaktuPemesananController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
        batasWaktuPemesananController.text = selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buat Perjalanan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Silahkan Masukan Data Perjalanan Anda",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: namapemberitumpanganController,
                decoration: InputDecoration(
                  labelText: "Nama Pemberi Tumpangan",
                  hintText: "Masukan Nama Pemberi Tumpangan",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
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
                decoration: InputDecoration(
                  labelText: 'Jenis Kendaraan',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.directions_car),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
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
                decoration: InputDecoration(
                  labelText: 'Jumlah Kursi',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.event_seat),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: biayaPerjalananController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Biaya perjalanan tidak boleh kosong';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Biaya perjalanan',
                  hintText: 'Masukkan biaya perjalanan',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.money),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: detailPerjalananController,
                decoration: InputDecoration(
                  labelText: 'Detail Perjalanan',
                  hintText: 'Masukkan detail perjalanan',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.details),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: batasWaktuPemesananController,
                onTap: () {
                  _selectTime(context);
                },
                decoration: InputDecoration(
                  labelText: 'Batas Waktu Pemesanan',
                  hintText: 'Masukkan batas waktu pemesanan',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.access_time),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (namapemberitumpanganController.text.isEmpty ||
                      selectedVehicleType.isEmpty ||
                      biayaPerjalananController.text.isEmpty ||
                      detailPerjalananController.text.isEmpty ||
                      batasWaktuPemesananController.text.isEmpty) {
                    final snackBar = const SnackBar(
                      content: Text('Data tidak boleh kosong'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Konfirmasi'),
                          content: const Text(
                              'Apakah Anda yakin ingin membuat perjalanan?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Batal'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Ya'),
                              onPressed: () async {
                                Navigator.of(context).pop();

                                final trip = Trip(
                                  user: namapemberitumpanganController.text,
                                  vehicleType: selectedVehicleType,
                                  seatCount: selectedSeatCount,
                                  cost: biayaPerjalananController.text,
                                  details: detailPerjalananController.text,
                                  deadline: batasWaktuPemesananController.text,
                                  date:
                                      "${selectedDate.toLocal()}".split(' ')[0],
                                  time: selectedTime.format(context),
                                );

                                try {
                                  final firestore = FirebaseFirestore.instance;
                                  await firestore
                                      .collection('trips')
                                      .add(trip.toMap());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Perjalanan Berhasil Dibuat. Silahkan tunggu untuk pengajuan dari pengguna lain. Dan Anda bisa melihat Tawaran Tumpangan anda di Menu Penumpang"),
                                    ),
                                  );

                                  await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => HomePage(),
                                    ),
                                  );
                                } catch (e) {
                                  print('Error adding trip: $e');
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Buat perjalanan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
