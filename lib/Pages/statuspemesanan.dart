import 'package:flutter/material.dart';

enum Status { menunggu, diterima, ditolak }

class StatusPemesananPage extends StatelessWidget {
  final Status status;

  StatusPemesananPage({required this.status});

  String getStatusText(Status status) {
    switch (status) {
      case Status.menunggu:
        return 'Menunggu';
      case Status.diterima:
        return 'Diterima';
      case Status.ditolak:
        return 'Ditolak';
    }
  }

  Color getStatusColor(Status status) {
    switch (status) {
      case Status.menunggu:
        return Colors.orange;
      case Status.diterima:
        return Colors.green;
      case Status.ditolak:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pemesanan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment,
              size: 100,
              color: getStatusColor(status),
            ),
            const SizedBox(height: 20),
            Text(
              getStatusText(status),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: getStatusColor(status),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
