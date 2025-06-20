import 'dart:async';
import 'package:flutter/material.dart';
import 'package:svitlo_ye/screens/region_select_page.dart';

class PowerOutagePage extends StatefulWidget {
  const PowerOutagePage({super.key});

  @override
  State<PowerOutagePage> createState() => _PowerOutagePageState();
}

class _PowerOutagePageState extends State<PowerOutagePage> {
  late DateTime _currentTime;
  late Timer _timer;
  bool isLightOn = true; // початковий стан світла

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      _currentTime = DateTime.now();
      isLightOn = !isLightOn; // переключаємо стан світла
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isLightOn
              ? "Дані оновлено. Світло є – заряджайте пристрої! 🔋"
              : "Світла немає – збережіть заряд! 🔦",
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: isLightOn ? Colors.yellow[800] : Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hour = _currentTime.hour.toString().padLeft(2, '0');
    final minute = _currentTime.minute.toString().padLeft(2, '0');
    final second = _currentTime.second.toString().padLeft(2, '0');

    final icon = isLightOn ? Icons.light_mode : Icons.power_off;
    final color = isLightOn ? Colors.yellow[600] : Colors.redAccent;
    final statusText = isLightOn ? 'Світло є' : 'Світла немає';
    final advice = isLightOn
        ? 'Зарядіть павербанки, ноутбуки та телефони.'
        : 'Світла немає. Економте заряд і чекайте відновлення.';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Іконка і статус світла
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 48,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // Поточний час
              const Text(
                'Поточний час',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$hour:$minute:$second',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                  color: color,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 40),

              // Порада
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color!.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color),
                ),
                child: Text(
                  advice,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              // Кнопка оновлення
              ElevatedButton.icon(
                onPressed: _refreshData,
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  "Оновити дані",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Кнопка зміни регіону
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegionSelectPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.location_on, color: Colors.white),
                label: const Text(
                  "Змінити регіон",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
