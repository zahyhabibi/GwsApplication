class Hospital {
  final String nama_pegawai;
  final String alamat;
  final int id;

  Hospital({
    required this.nama_pegawai,
    required this.alamat,
    required this.id,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      nama_pegawai: json['nama_pegawai'],
      alamat: json['alamat'],
      id: int.parse(json['id']),
    );
  }
}
