import 'package:flutter/material.dart';
import 'package:gws/repository.dart';
import 'package:gws/model.dart';

class Datapi extends StatefulWidget {
  @override
  _DatapiState createState() => _DatapiState();
}

class _DatapiState extends State<Datapi> {
  List<Hospital> listHospital = [];
  Repository repository = Repository();

  Future<void> getData() async {
    try {
      List<Hospital> data = await repository.getData();
      setState(() {
        listHospital = data;
      });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> getDataById(int id) async {
    try {
      Hospital hospital = await repository.getDataById(id);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Hospital'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('ID: ${hospital.id}'),
              Text('Nama Pegawai: ${hospital.nama_pegawai}'),
              Text('Alamat: ${hospital.alamat}'),
            ],
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> postData(String namaPegawai, String alamat) async {
    try {
      bool success = await repository.postData(namaPegawai, alamat);
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Data berhasil ditambahkan.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getData();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Gagal menambahkan data.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> putData(int id, String namaPegawai, String alamat) async {
    try {
      bool success = await repository.putData(id, namaPegawai, alamat);
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Data berhasil diperbarui.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getData();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Gagal memperbarui data.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  Future<void> deleteData(int id) async {
    try {
      bool success = await repository.deleteData(id);
      if (success) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Sukses'),
            content: Text('Data berhasil dihapus.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  getData();
                },
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Gagal menghapus data.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pegawai'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: listHospital.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(listHospital[index].nama_pegawai),
                      subtitle: Text(listHospital[index].alamat),
                      trailing: Text(listHospital[index].id.toString()),
                      onTap: () => getDataById(listHospital[index].id),
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => EditDeleteDialog(
                            onDelete: () {
                              Navigator.of(context).pop();
                              deleteData(listHospital[index].id);
                            },
                            onEdit: (namaPegawai, alamat) {
                              Navigator.of(context).pop();
                              putData(
                                  listHospital[index].id, namaPegawai, alamat);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
                itemCount: listHospital.length,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddDataDialog(
              onAddData: (namaPegawai, alamat) {
                Navigator.of(context).pop();
                postData(namaPegawai, alamat);
              },
            ),
          );
        },
      ),
    );
  }
}

class AddDataDialog extends StatefulWidget {
  final Function(String, String) onAddData;

  AddDataDialog({required this.onAddData});

  @override
  _AddDataDialogState createState() => _AddDataDialogState();
}

class _AddDataDialogState extends State<AddDataDialog> {
  TextEditingController _namaPegawaiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Data Hospital'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _namaPegawaiController,
            decoration: InputDecoration(labelText: 'Nama Pegawai'),
          ),
          TextField(
            controller: _alamatController,
            decoration: InputDecoration(labelText: 'Alamat'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Batal'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Tambah'),
          onPressed: () {
            String namaPegawai = _namaPegawaiController.text;
            String alamat = _alamatController.text;
            widget.onAddData(namaPegawai, alamat);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _namaPegawaiController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}

class EditDeleteDialog extends StatefulWidget {
  final Function() onDelete;
  final Function(String, String) onEdit;

  EditDeleteDialog({required this.onDelete, required this.onEdit});

  @override
  _EditDeleteDialogState createState() => _EditDeleteDialogState();
}

class _EditDeleteDialogState extends State<EditDeleteDialog> {
  TextEditingController _namaPegawaiController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Aksi'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _namaPegawaiController,
            decoration: InputDecoration(labelText: 'Nama Pegawai'),
          ),
          TextField(
            controller: _alamatController,
            decoration: InputDecoration(labelText: 'Alamat'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Hapus'),
          onPressed: () => widget.onDelete(),
        ),
        TextButton(
          child: Text('Perbarui'),
          onPressed: () {
            String namaPegawai = _namaPegawaiController.text;
            String alamat = _alamatController.text;
            widget.onEdit(namaPegawai, alamat);
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _namaPegawaiController.dispose();
    _alamatController.dispose();
    super.dispose();
  }
}
