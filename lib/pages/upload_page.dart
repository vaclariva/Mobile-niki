import 'package:flutter/material.dart';
import 'package:sneaker_shop_app/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  final VoidCallback? onDataChanged;

  const UploadPage({Key? key, this.onDataChanged}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imagepathController = TextEditingController();

  List<Map<String, dynamic>> catatan = [];
  Map<String, dynamic>? catatanDihapus;

  void refreshCatatan() async {
    final data = await SQLHelper.getCatatan3();
    setState(() {
      catatan = data;
    });
  }

  @override
  void initState() {
    refreshCatatan();
    super.initState();
  }

  Future<void> _ambilGambar() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imagepathController.text = pickedFile.path;
      });
    }
  }

  Future<void> tambahCatatan() async {
    await SQLHelper.tambahCatatan3(
      titleController.text,
      priceController.text,
      descriptionController.text,
      imagepathController.text,
    );
    refreshCatatan();

    // Setel ulang nilai controller setelah perubahan
    titleController.text = '';
    priceController.text = '';
    descriptionController.text = '';
    imagepathController.text = '';

    // Panggil callback untuk memberi tahu perubahan data
    if (widget.onDataChanged != null) {
      widget.onDataChanged!();
    }
  }

  Future<void> hapusCatatan(int id) async {
    catatanDihapus = catatan.firstWhere((item) => item['id'] == id);
    await SQLHelper.hapusCatatan3(id);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Berhasil Dihapus",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            if (catatanDihapus != null) {
              tambahCatatan();
              catatanDihapus = null;
            }
          },
          textColor: Colors.yellow,
        ),
      ),
    );

    refreshCatatan();
  }

  Future<void> ubahCatatan(int id) async {
    await SQLHelper.ubahCatatan3(
      id,
      titleController.text,
      priceController.text,
      descriptionController.text,
      imagepathController.text,
    );
    refreshCatatan();

    // Setel ulang nilai controller setelah perubahan
    titleController.text = '';
    priceController.text = '';
    descriptionController.text = '';
    imagepathController.text = '';

    // Panggil callback untuk memberi tahu perubahan data
    if (widget.onDataChanged != null) {
      widget.onDataChanged!();
    }
  }

  void modalForm(int? id) async {
    if (id != null) {
      final dataCatatan = catatan.firstWhere((item) => item['id'] == id);

      titleController.text = dataCatatan['title'];
      priceController.text = dataCatatan['price'];
      descriptionController.text = dataCatatan['description'];
      imagepathController.text = dataCatatan['imagepath'];
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 800,
        color: const Color.fromARGB(255, 248, 248, 248),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Masukkan Judul"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: priceController,
                decoration:
                    const InputDecoration(hintText: "Masukkan Harga"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: descriptionController,
                decoration:
                    const InputDecoration(hintText: "Masukkan Deskripsi"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: imagepathController,
                decoration:
                    const InputDecoration(hintText: "Path Gambar"),
              ),
              ElevatedButton(
                onPressed: _ambilGambar,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 158, 158, 158),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.black),
                    SizedBox(width: 8),
                    Text(
                      "Pilih Gambar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (titleController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      imagepathController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.yellow[50],
                        title: Text(
                          "Form Kosong",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        content: Text(
                          "Pastikan semua form diisi sebelum menambahkan data.",
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellow,
                            ),
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    if (id == null) {
                      await tambahCatatan();
                    } else {
                      await ubahCatatan(id);
                    }
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 159, 159, 159),
                ),
                child: Text(
                  id == null ? 'Tambah Data' : 'Ubah Data',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Data Sepatu",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.grey, // Warna latar belakang abu-abu AppBar
      ),
      body: ListView.builder(
        itemCount: catatan.length,
        itemBuilder: (context, index) => Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Color.fromARGB(255, 223, 223, 223), width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Image.file(
                    File(catatan[index]['imagepath']),
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            catatan[index]['title'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(catatan[index]['price']),
                          const SizedBox(height: 8),
                          Text(catatan[index]['description']),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 233, 33),
                            child: IconButton(
                              onPressed: () => modalForm(catatan[index]['id']),
                              icon: Icon(
                                Icons.edit,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 255, 59, 59),
                            child: IconButton(
                              onPressed: () {
                                hapusCatatan(catatan[index]['id']);
                              },
                              icon:
                                  Icon(Icons.delete, color: Color.fromARGB(255, 250, 250, 249)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modalForm(null);
        },
        tooltip: 'Tambah Data',
        backgroundColor: Color.fromARGB(255, 166, 166, 166),
        child: const Icon(Icons.add),
      ),
    );
  }
}
