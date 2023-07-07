import 'package:flutter/material.dart';
import 'package:gws/Screens/HomePage.dart';
import 'package:gws/Screens/datapi.dart';

class Dashboard extends StatelessWidget {
  final String loggedInUser;

  Dashboard({required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          TextButton(
            onPressed: () {
              // Fungsi Logout
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Konfirmasi Logout'),
                  content: Text('Apakah Anda yakin ingin keluar?'),
                  actions: [
                    TextButton(
                      child: Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Logout'),
                      onPressed: () {
                        // Tindakan Logout
                        Navigator.of(context)
                            .pop(); // Menutup dialog konfirmasi logout
                        Navigator.of(context)
                            .pop(); // Kembali ke halaman login atau sebelumnya
                      },
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
        automaticallyImplyLeading: false, // Menghilangkan tanda panah ke kiri
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            alignment: FractionalOffset(0, 0.75),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: 232.0),
            width: 292, // Set width and height to make it square
            height: 292,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 0.0),
                    Text(
                      'Selamat datang di GWS, $loggedInUser!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Silahkan Pilih kedua menu dibawah ^_^',
                      style: TextStyle(fontSize: 12.0),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          },
                          child: Text('Data Pasien'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Datapi()),
                            );
                          },
                          child: Text('Data Pegawai'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
