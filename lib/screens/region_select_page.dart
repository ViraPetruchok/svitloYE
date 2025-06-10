import 'package:flutter/material.dart';
import 'package:svitlo_ye/screens/home_page.dart';

class RegionSelectPage extends StatefulWidget {
  const RegionSelectPage({super.key});

  @override
  _RegionSelectPageState createState() => _RegionSelectPageState();
}

class _RegionSelectPageState extends State<RegionSelectPage> {
  String? selectedOblast;
  String? selectedRegion;
  String? selectedStreet;

  final Map<String, List<String>> regionsByOblast = {
  'Львівська область': ['Львів', 'Дрогобич', 'Стрий'],
  'Київська область': ['Бровари', 'Біла Церква', 'Ірпінь'],
  'Харківська область': ['Харків', 'Ізюм', 'Лозова'],
  'Одеська область': ['Одеса', 'Ізмаїл', 'Білгород-Дністровський'],
  'Дніпропетровська область': ['Дніпро', 'Кривий Ріг', 'Нікополь'],
  'Запорізька область': ['Запоріжжя', 'Мелітополь'],
  'Вінницька область': ['Вінниця', 'Жмеринка'],
  'Полтавська область': ['Полтава', 'Кременчук'],
  // додай інші, які потрібні
};

  final Map<String, List<String>> streetsByRegion = {
    'Львів': ['вул. Шевченка', 'вул. Франка', 'вул. Городоцька'],
    'Дрогобич': ['вул. Стрийська', 'вул. Грушевського'],
    'Стрий': ['вул. Січових Стрільців'],
    'Бровари': ['вул. Київська', 'вул. Гагаріна'],
    'Біла Церква': ['вул. Ярослава Мудрого', 'вул. Леваневського'],
    'Ірпінь': ['вул. Університетська', 'вул. Центральна'],
    'Харків': ['вул. Пушкінська', 'вул. Сумська'],
    'Ізюм': ['вул. Київська', 'вул. Першотравнева'],
    'Лозова': ['вул. Соборна', 'вул. Шевченка'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Де ви знаходитесь?',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              dropdownColor: Colors.grey[900],
              iconEnabledColor: Colors.white,
              style: TextStyle(color: Colors.white),
              isExpanded: true,
              value: selectedOblast,
              hint: Text('Оберіть область', style: TextStyle(color: Colors.white)),
              items: regionsByOblast.keys.map((String oblast) {
                return DropdownMenuItem<String>(
                  value: oblast,
                  child: Text(oblast),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedOblast = value;
                  selectedRegion = null;
                  selectedStreet = null;
                });
              },
            ),
            SizedBox(height: 30),
            if (selectedOblast != null) ...[
              Text(
                'Оберіть ваш населений пункт:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                dropdownColor: Colors.grey[900],
                iconEnabledColor: Colors.white,
                style: TextStyle(color: Colors.white),
                isExpanded: true,
                value: selectedRegion,
                hint: Text('Оберіть регіон', style: TextStyle(color: Colors.white)),
                items: (regionsByOblast[selectedOblast] ?? []).map((String region) {
                  return DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRegion = value;
                    selectedStreet = null;
                  });
                },
              ),
            ],
            SizedBox(height: 30),
            if (selectedRegion != null) ...[
              Text(
                'Оберіть вашу вулицю:',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButton<String>(
                dropdownColor: Colors.grey[900],
                iconEnabledColor: Colors.white,
                style: TextStyle(color: Colors.white),
                isExpanded: true,
                value: selectedStreet,
                hint: Text('Оберіть вулицю', style: TextStyle(color: Colors.white)),
                items: (streetsByRegion[selectedRegion] ?? []).map((String street) {
                  return DropdownMenuItem<String>(
                    value: street,
                    child: Text(street),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStreet = value;
                  });
                },
              ),
            ],
            Spacer(),
            if (selectedOblast != null && selectedRegion != null && selectedStreet != null) ...[
              SizedBox(height: 20),
              Center(
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500),
                  child: Text(
                    'Ви обрали: $selectedOblast → $selectedRegion → $selectedStreet',
                    style: TextStyle(fontSize: 18, color: Colors.yellow),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: (selectedStreet != null)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                child: Text('Далі'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
