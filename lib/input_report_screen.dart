import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:penyuku/controllers/report_controller.dart';

class PencatatanScreen extends StatefulWidget {
  const PencatatanScreen({super.key});

  @override
  State<PencatatanScreen> createState() => _PencatatanScreenState();
}

class _PencatatanScreenState extends State<PencatatanScreen> {
  final ReportController _reportController =  ReportController();
  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;
  String? _selectedTurtleType;
  String _gender = 'Betina'; 
  int _eggCount = 0;
  DateTime _foundDate = DateTime.now();
  Position? _currentPosition;
  bool _isLoading = false;
  bool _isGettingLocation = false;

  final List<String> _turtleTypes = [
    'Penyu Hijau',
    'Penyu Sisik',
    'Penyu Lekang',
    'Penyu Belimbing',
    'Penyu Tempayan',
    'Penyu Pipih'
  ];

  void _showSnackbar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg), 
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
      ),
    );
  }

  void _showImageSourceChoice(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Color(0xFF1A2B45)),
                title: Text('Ambil Foto (Kamera)', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context); 
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF1A2B45)),
                title: Text('Pilih dari Galeri', style: GoogleFonts.poppins()),
                onTap: () {
                  Navigator.pop(context); 
                  _pickImage(ImageSource.gallery); 
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if(pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isGettingLocation = true);

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) {
      _showSnackbar("Aktifkan GPS Anda!", Colors.orange);
      setState(()=> _isGettingLocation = false);
      return;
    }

    // Ask User Permission
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        _showSnackbar("Akses GPS Ditolak", Colors.red);
        setState(()=> _isGettingLocation = false);
        return;
      }
    }

    if(permission == LocationPermission.deniedForever) {
      _showSnackbar("Tidak Memiliki Izin Lokasi", Colors.red);
      setState(()=> _isGettingLocation = false);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition =  position;
      _isGettingLocation = false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _foundDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if(picked != null && picked != _foundDate) {
      setState(() {
        _foundDate = picked;
      });
    }
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    if(_currentPosition == null) {
      _showSnackbar("Mohon Ambil Titik Lokasi Terlebih Dahulu", Colors.red);
      return;
    }

    setState(()=> _isLoading =  true);

    try{
      await _reportController.submitReport(
        turtleType: _selectedTurtleType!, 
        gender: _gender, 
        eggCount: _eggCount, 
        foundDate: _foundDate, 
        lat: _currentPosition!.latitude, 
        long: _currentPosition!.longitude,
        imageFile: _selectedImage
      );

      _showSnackbar("Laporan Berhasil Terkirim", Colors.green);
      Navigator.pop(context);
    } catch (e) {
      _showSnackbar("Gagal mengirim: ${e.toString().replaceAll("Exception: ", "")}", Colors.red);
    } finally {
      setState(() => _isLoading = false);
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Laporan", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: ()=> _showImageSourceChoice(context),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    image: _selectedImage != null
                        ? DecorationImage(image: FileImage(_selectedImage!), fit: BoxFit.cover)
                        : null,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: _selectedImage == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                            Text("Tap untuk ambil foto", style: GoogleFonts.poppins(color: Colors.grey)),
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),

              Text("Jenis Penyu", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedTurtleType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text("Pilih Jenis Penyu"),
                items: _turtleTypes.map((String type) {
                  return DropdownMenuItem<String>(value: type, child: Text(type));
                }).toList(),
                onChanged: (val) => setState(() => _selectedTurtleType = val),
                validator: (val) => val == null ? 'Wajib dipilih' : null,
              ),
              const SizedBox(height: 20),

              Text("Jenis Kelamin", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Betina", style: GoogleFonts.poppins(fontSize: 14)),
                      value: "Betina",
                      groupValue: _gender,
                      onChanged: (val) => setState(() => _gender = val!),
                      activeColor: const Color(0xFF1A2B45),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Jantan", style: GoogleFonts.poppins(fontSize: 14)),
                      value: "Jantan",
                      groupValue: _gender,
                      onChanged: (val) => setState(() => _gender = val!),
                      activeColor: const Color(0xFF1A2B45),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Text("Jumlah Telur", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () {
                        if (_eggCount > 0) setState(() => _eggCount--);
                      },
                    ),
                    Text(
                      "$_eggCount Butir",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                      onPressed: () {
                        setState(() => _eggCount++);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text("Tanggal Ditemukan", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(_foundDate), // Perlu inisialisasi dateformatting di main.dart jika error locale
                        style: GoogleFonts.poppins(),
                      ),
                      const Icon(Icons.calendar_today, color: Colors.grey),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Text("Titik Lokasi", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _currentPosition == null ? Colors.red.shade200 : Colors.green.shade200),
                ),
                child: Column(
                  children: [
                    if (_currentPosition != null)
                      Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Lat: ${_currentPosition!.latitude}\nLong: ${_currentPosition!.longitude}",
                                  style: GoogleFonts.poppins(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Lokasi terkunci akurat!",
                            style: GoogleFonts.poppins(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    else
                      const Text("Lokasi belum diambil"),
                    
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isGettingLocation ? null : _getCurrentLocation,
                        icon: _isGettingLocation 
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.my_location),
                        label: Text(_isGettingLocation ? "Sedang mencari..." : "Ambil Lokasi Saat Ini"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A2B45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Kirim Laporan", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  