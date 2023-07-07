import 'package:flutter/material.dart';
import 'package:gws/db_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _nama_pasienController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();

  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData =
          _allData.firstWhere((element) => element['id'] == id);
      _nama_pasienController.text = existingData['nama_pasien'];
      _detailController.text = existingData['detail'];
    }
    showModalBottomSheet(
      elevation: 5,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _nama_pasienController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Nama Pasien",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _detailController,
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Detail Indikasi",
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  }
                  if (id != null) {
                    await _updateData(id);
                  }

                  _nama_pasienController.text = "";
                  _detailController.text = "";

                  Navigator.of(context).pop();
                  print("Data Ditambahkan");
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Tambah Data" : "Update",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addData() async {
    await SQLHelper.createdData(
        _nama_pasienController.text, _detailController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(
        id, _nama_pasienController.text, _detailController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text("Data Terhapus"),
    ));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GWS Hospital - Data Pasien"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white.withOpacity(0.1),
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _allData.length,
                    itemBuilder: (context, index) => Card(
                      margin: EdgeInsets.all(15),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            _allData[index]['nama_pasien'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        subtitle: Text(_allData[index]['detail']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                showBottomSheet(_allData[index]['id']);
                              },
                              icon: Icon(Icons.edit, color: Colors.black),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteData(_allData[index]['id']);
                              },
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(height: 80),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
