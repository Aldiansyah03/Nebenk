import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nebengk/Pages/HomePage.dart';
import 'package:nebengk/maps/current_location_Screen.dart';

class Trip {
  String user;
  String vehicleType;
  int seatCount;
  String cost;
  String details;
  String deadline;
  String tanggalbatas;
  String datemake;
  String time;
  String location;

  Trip({
    required this.user,
    required this.vehicleType,
    required this.seatCount,
    required this.cost,
    required this.details,
    required this.deadline,
    required this.tanggalbatas,
    required this.datemake,
    required this.time,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user,
      'vehicleType': vehicleType,
      'seatCount': seatCount,
      'cost': cost,
      'details': details,
      'tanggalbatas': tanggalbatas,
      'deadline': deadline,
      'date': datemake,
      'time': time,
      'location': location,
    };
  }
}

class BeriTumpangan extends StatefulWidget {
  final LatLng? selectedLocation;
  BeriTumpangan({Key? key, this.selectedLocation}) : super(key: key);

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
  TextEditingController datetimePerjalananController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.selectedLocation != null) {
      locationController.text =
          "${widget.selectedLocation!.latitude}, ${widget.selectedLocation!.longitude}";
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          datetimePerjalananController.text =
              "${selectedDateTime.toLocal()}".split('.')[0];
          locationController.text = '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3668B2),
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
              // const SizedBox(height: 16),
              // TextFormField(
              //   controller: biayaPerjalananController,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: <TextInputFormatter>[
              //     FilteringTextInputFormatter.digitsOnly
              //   ],
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Biaya perjalanan tidak boleh kosong';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     labelText: 'Biaya perjalanan',
              //     hintText: 'Masukkan biaya perjalanan',
              //     filled: true,
              //     fillColor: Colors.white,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     prefixIcon: const Icon(Icons.money),
              //   ),
              // ),
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
                controller: datetimePerjalananController,
                onTap: () {
                  _selectDateTime(context);
                },
                decoration: InputDecoration(
                  labelText: 'Tanggal & Waktu Perjalanan',
                  hintText: 'Pilih Tanggal & Waktu',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(Icons.date_range),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: locationController,
                onTap: () async {
                  final selectedLocation =
                      await Navigator.of(context).push<LatLng>(
                    MaterialPageRoute(
                      builder: (context) => CurrentLocationScreen(),
                    ),
                  );

                  if (selectedLocation != null) {
                    locationController.text =
                        "${selectedLocation.latitude}, ${selectedLocation.longitude}";
                  }
                  // Tentukan variabel result
                  // Map<String, String>? result;

                  // result = await Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => CurrentLocationScreen(),
                  //   ),
                  // );
                },
                decoration: InputDecoration(
                  labelText: 'Map Information',
                  hintText: 'Enter map information',
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.map),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final currentContext = context;
                      if (namapemberitumpanganController.text.isEmpty ||
                          selectedVehicleType.isEmpty ||
                          detailPerjalananController.text.isEmpty ||
                          datetimePerjalananController.text.isEmpty) {
                        const snackBar = SnackBar(
                          content: Text('Data tidak boleh kosong'),
                        );
                        ScaffoldMessenger.of(currentContext)
                            .showSnackBar(snackBar);
                      } else {
                        showDialog(
                          context: currentContext,
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

                                    final now = DateTime.now();
                                    final trip = Trip(
                                      user: namapemberitumpanganController.text,
                                      vehicleType: selectedVehicleType,
                                      seatCount: selectedSeatCount,
                                      cost: biayaPerjalananController.text,
                                      details: detailPerjalananController.text,
                                      tanggalbatas:
                                          datetimePerjalananController.text,
                                      deadline:
                                          datetimePerjalananController.text,
                                      datemake:
                                          "${now.toLocal()}".split(' ')[0],
                                      time:
                                          selectedDateTime.toLocal().toString(),
                                      location: locationController
                                          .text, // Tambahkan baris ini
                                    );

                                    try {
                                      final firestore =
                                          FirebaseFirestore.instance;
                                      await firestore
                                          .collection('trips')
                                          .add(trip.toMap());
                                      ScaffoldMessenger.of(currentContext)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Perjalanan Berhasil Dibuat. Silahkan tunggu untuk pengajuan dari pengguna lain. Dan Anda bisa melihat Tawaran Tumpangan anda di Menu Penumpang"),
                                        ),
                                      );

                                      await Navigator.of(currentContext)
                                          .pushReplacement(
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
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF3668B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    child: const Text('Buat perjalanan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
