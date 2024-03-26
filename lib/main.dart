import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp()); // Titik masuk aplikasi
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer (Ave Sena | 222410102039)', // Judul aplikasi
      home: TimerScreen(), // Halaman utama aplikasi
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() =>
      _TimerScreenState(); // Membuat state untuk layar timer
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0; // Variabel untuk menyimpan detik yang tersisa
  bool _isActive = false; // Flag untuk melacak apakah timer aktif atau tidak
  late TextEditingController _controller; // Controller untuk field teks

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // Menginisialisasi controller
  }

  @override
  void dispose() {
    _controller.dispose(); // Menghapus controller untuk membebaskan sumber daya
    super.dispose();
  }

  void _startTimer() {
    int minutes = int.tryParse(_controller.text) ?? 0; // Parsing menit input
    if (minutes > 0) {
      setState(() {
        _seconds = minutes * 60; // Mengubah menit menjadi detik
        _isActive = true; // Mengatur timer aktif
      });
      _runTimer(); // Memulai timer
    }
  }

  void _stopTimer() {
    setState(() {
      _isActive = false; // Menghentikan timer
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0; // Mereset detik
      _isActive = false; // Menghentikan timer
      _controller.clear(); // Menghapus field teks
    });
  }

  void _runTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_isActive && _seconds > 0) {
        setState(() {
          _seconds--; // Mengurangi detik yang tersisa
        });
        _runTimer(); // Memanggil dirinya sendiri secara rekursif setelah 1 detik
      } else {
        setState(() {
          _isActive = false; // Timer berhenti ketika waktunya habis
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer (Ave Sena | 222410102039)'), // Judul AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller, // Field teks untuk memasukkan menit
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Menit',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$_seconds detik', // Menampilkan detik yang tersisa
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isActive
                      ? _stopTimer
                      : _startTimer, // Tombol Mulai/Berhenti
                  child: Text(_isActive
                      ? 'Berhenti'
                      : 'Mulai'), // Teks berubah berdasarkan status timer
                ),
                ElevatedButton(
                  onPressed: _resetTimer, // Tombol Reset
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
