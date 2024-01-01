class Foto { // Membuat class Foto untuk merepresentasikan data foto
  final int? id; // ID foto, bisa null karena merupakan parameter opsional
  final String judul; // Judul foto, wajib diisi
  final String deskripsi; // Deskripsi foto, wajib diisi
  final String photo; // Nama file foto, wajib diisi

  const Foto({this.id, required this.judul, required this.deskripsi, required this.photo}); // Konstruktor dengan parameter opsional dan wajib diisi

  Map<String, dynamic> toList(){ // Metode untuk mengubah objek Foto menjadi Map
    return {'id' : id, 'judul' : judul, 'deskripsi' : deskripsi, 'photo' : photo};
  }

  @override
  String toString(){ // Metode override untuk menghasilkan representasi string dari objek Foto
    return "{'id' : id, 'judul' : judul, 'deskripsi' : deskripsi, 'photo' : photo}";
  }
}