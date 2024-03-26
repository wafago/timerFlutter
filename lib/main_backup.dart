import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      home: TimerScreen(),
    );
  }
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int _seconds = 0;
  bool _isActive = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
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
        title: Text('Timer App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter minutes',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$_seconds seconds',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isActive ? _stopTimer : _startTimer,
                  child: Text(_isActive ? 'Stop' : 'Start'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
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
