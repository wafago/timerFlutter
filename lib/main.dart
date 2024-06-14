import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer (Mohammad Aly Al Wafa | 222410102089)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 18, color: Colors.black87),
        ),
      ),
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> with SingleTickerProviderStateMixin {
  int _seconds = 0;
  bool _isActive = false;
  late TextEditingController _controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  final List<Color> _rainbowColors = [
    Colors.red, Colors.orange, Colors.yellow, Colors.green, 
    Colors.blue, Colors.indigo, Colors.purple
  ];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    int minutes = int.tryParse(_controller.text) ?? 0;
    if (minutes > 0) {
      setState(() {
        _seconds = minutes * 60;
        _isActive = true;
      });
      _runTimer();
    }
  }

  void _stopTimer() {
    setState(() {
      _isActive = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isActive = false;
      _controller.clear();
    });
  }

  void _runTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (_isActive && _seconds > 0) {
        setState(() {
          _seconds--;
        });
        _animationController.forward();
        _runTimer();
      } else {
        setState(() {
          _isActive = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer (Mohammad Aly Al Wafa | 222410102089)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Masukkan Menit',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ScaleTransition(
              scale: _animation,
              child: Text(
                '$_seconds detik',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: _rainbowColors[_seconds % _rainbowColors.length],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isActive ? _stopTimer : _startTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isActive ? Colors.red : Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text(_isActive ? 'Berhenti' : 'Mulai'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue.shade50,
    );
  }
}
