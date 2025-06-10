import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PowerOutagePage extends StatefulWidget {
  const PowerOutagePage({super.key});

  @override
  State<PowerOutagePage> createState() => _PowerOutagePageState();
}

class _PowerOutagePageState extends State<PowerOutagePage> {
  String status = "Світло є";
  String lastUpdate = "09 червня, 12:45";
  int hoursToday = 2;
  String avgDuration = "1 год 20 хв";

  final List<Map<String, dynamic>> outageHistory = [
    {"day": "06.06", "hours": 2},
    {"day": "07.06", "hours": 1},
    {"day": "08.06", "hours": 3},
    {"day": "09.06", "hours": 2},
  ];

  void _refreshData() {
    setState(() {
      lastUpdate = "09 червня, 13:00";
      hoursToday = 3;
      status = "Світло відсутнє";
      outageHistory.last['hours'] = 3;
    });
  }

  void _subscribe() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ви будете отримувати сповіщення.')),
    );
  }

  Widget _buildChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 5,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                int index = value.toInt();
                if (index >= 0 && index < outageHistory.length) {
                  return Text(outageHistory[index]['day']);
                }
                return const Text('');
              },
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: outageHistory.asMap().entries.map((entry) {
          int index = entry.key;
          final item = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: item['hours'].toDouble(),
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Поточний статус:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: 20,
                color: status == "Світло є" ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 12),
            Text("Останнє оновлення: $lastUpdate"),

            const SizedBox(height: 24),
            const Text(
              "Динаміка відключень за останні дні",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(height: 200, child: _buildChart()),

            const SizedBox(height: 24),
            const Text(
              "Додаткова інформація",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Середня тривалість відключень: $avgDuration"),
            Text("Годин без світла сьогодні: $hoursToday"),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _refreshData,
                  child: const Text("Оновити дані"),
                ),
                OutlinedButton(
                  onPressed: _subscribe,
                  child: const Text("Сповіщати мене"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
