import 'package:flutter/material.dart';

class checkNumberType extends StatefulWidget {
  const checkNumberType({super.key});

  @override
  State<checkNumberType> createState() => _checkNumberTypeState();
}

class _checkNumberTypeState extends State<checkNumberType> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  String? _error;

  void _checkNumber() {
    setState(() {
      _error = null;
      _result = '';
      final input = _controller.text.trim();

      if (input.isEmpty) {
        _error = 'Silakan masukkan sebuah angka.';
        return;
      }

      final number = num.tryParse(input);
      if (number == null) {
        _error = 'Input tidak valid. Masukkan angka yang benar.';
        return;
      }

      List<String> resultTypes = [];

      if (number is int || number == number.roundToDouble()) {
        int n = number.toInt();

        if (n > 1 && _isPrime(n)) {
          resultTypes.add('Bilangan Prima');
        }

        if (n >= 0) {
          resultTypes.add('Bilangan Cacah');
        }

        if (n > 0) {
          resultTypes.add('Bilangan Bulat Positif');
        } else if (n < 0) {
          resultTypes.add('Bilangan Bulat Negatif');
        }

        resultTypes.add('Bilangan Bulat');
      } else {
        resultTypes.add('Bilangan Desimal');
      }

      _result = 'Termasuk: ${resultTypes.join(', ')}';
    });
  }

  bool _isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _result = '';
        _error = null;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jenis Bilangan'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Masukkan sebuah angka untuk mengetahui jenis bilangan:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan angka',
                border: OutlineInputBorder(),
                errorText: _error,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkNumber,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Cek Jenis Bilangan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_result.isNotEmpty)
              Card(
                color: Colors.blueAccent.shade100,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _result,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
