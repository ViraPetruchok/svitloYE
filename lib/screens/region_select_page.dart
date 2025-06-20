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
    'Вінницька область': ['Вінниця', 'Жмеринка', 'Могилів-Подільський', 'Козятин', 'Хмільник', 'Тульчин', 'Бар'],
    'Волинська область': ['Луцьк', 'Ковель', 'Нововолинськ', 'Володимир', 'Ратне', 'Маневичі', 'Любешів'],
    'Дніпропетровська область': ['Дніпро', 'Кривий Ріг', 'Нікополь', 'Павлоград', 'Марганець', 'Камʼянське', 'Жовті Води'],
    'Донецька область': ['Краматорськ', 'Словʼянськ', 'Маріуполь', 'Бахмут', 'Торецьк', 'Волноваха', 'Дружківка'],
    'Житомирська область': ['Житомир', 'Бердичів', 'Коростень', 'Малин', 'Новоград-Волинський', 'Овруч', 'Чуднів'],
    'Закарпатська область': ['Ужгород', 'Мукачево', 'Хуст', 'Берегове', 'Виноградів', 'Іршава', 'Тячів'],
    'Запорізька область': ['Запоріжжя', 'Мелітополь', 'Бердянськ', 'Токмак', 'Енергодар', 'Пологи', 'Оріхів'],
    'Івано-Франківська область': ['Івано-Франківськ', 'Калуш', 'Коломия', 'Надвірна', 'Болехів', 'Долина', 'Тлумач'],
    'Київська область': ['Бровари', 'Біла Церква', 'Ірпінь', 'Вишгород', 'Фастів', 'Обухів', 'Боярка'],
    'Кіровоградська область': ['Кропивницький', 'Олександрія', 'Світловодськ', 'Знамʼянка', 'Долинська', 'Гайворон', 'Мала Виска'],
    'Луганська область': ['Сєвєродонецьк', 'Лисичанськ', 'Рубіжне', 'Старобільськ', 'Щастя', 'Новопсков', 'Біловодськ'],
    'Львівська область': ['Львів', 'Дрогобич', 'Стрий', 'Червоноград', 'Самбір', 'Голосковичі', 'Пониковиця', 'Вербляни', 'Рожанка', 'Буськ', 'Броди'],
    'Миколаївська область': ['Миколаїв', 'Вознесенськ', 'Первомайськ', 'Южноукраїнськ', 'Очаків', 'Баштанка', 'Новий Буг'],
    'Одеська область': ['Одеса', 'Ізмаїл', 'Білгород-Дністровський', 'Южне', 'Подільськ', 'Татарбунари', 'Кілія'],
    'Полтавська область': ['Полтава', 'Кременчук', 'Миргород', 'Лубни', 'Горішні Плавні', 'Гадяч', 'Зіньків'],
    'Рівненська область': ['Рівне', 'Дубно', 'Сарни', 'Костопіль', 'Здолбунів', 'Березне', 'Корець'],
    'Сумська область': ['Суми', 'Шостка', 'Конотоп', 'Охтирка', 'Глухів', 'Тростянець', 'Ромни'],
    'Тернопільська область': ['Тернопіль', 'Чортків', 'Кременець', 'Бережани', 'Збараж', 'Зборів', 'Ланівці'],
    'Харківська область': ['Харків', 'Ізюм', 'Лозова', 'Чугуїв', 'Купʼянськ', 'Балаклія', 'Первомайський'],
    'Херсонська область': ['Херсон', 'Нова Каховка', 'Каховка', 'Гола Пристань', 'Скадовськ', 'Берислав', 'Олешки'],
    'Хмельницька область': ['Хмельницький', 'Камʼянець-Подільський', 'Шепетівка', 'Старокостянтинів', 'Нетішин', 'Деражня', 'Волочиськ'],
    'Черкаська область': ['Черкаси', 'Умань', 'Сміла', 'Канів', 'Золотоноша', 'Шпола', 'Жашків'],
    'Чернівецька область': ['Чернівці', 'Новодністровськ', 'Кіцмань', 'Сторожинець', 'Хотин', 'Заставна', 'Глибока'],
    'Чернігівська область': ['Чернігів', 'Ніжин', 'Прилуки', 'Новгород-Сіверський', 'Бахмач', 'Бобровиця', 'Корюківка'],
  };

  final Map<String, List<String>> streetsByRegion = {
    'Львів': ['вул. Шевченка', 'вул. Франка', 'вул. Городоцька', 'вул. Личаківська', 'вул. Зелена', 'вул. Стрийська', 'вул. Кульпарківська', 'вул. Наукова', 'вул. Під Дубом', 'вул. Пасічна'],
    'Дрогобич': ['вул. Стрийська', 'вул. Грушевського', 'вул. Самбірська', 'вул. Бориславська'],
    'Стрий': ['вул. Січових Стрільців', 'вул. Шевченка', 'вул. Незалежності'],
    'Голосковичі': ['вул. Центральна', 'вул. Польова'],
    'Пониковиця': ['вул. Шевченка', 'вул. Сонячна'],
    'Вербляни': ['вул. Лісова', 'вул. Садова'],
    'Рожанка': ['вул. Шкільна', 'вул. Миру'],
    'Буськ': ['вул. Грушевського', 'вул. Лісна'],
    'Броди': ['вул. Зелена', 'вул. Незалежності'],
    'Бровари': ['вул. Київська', 'вул. Гагаріна', 'вул. Героїв Небесної Сотні'],
    'Біла Церква': ['вул. Ярослава Мудрого', 'вул. Леваневського', 'вул. Івана Кожедуба'],
    'Ірпінь': ['вул. Університетська', 'вул. Центральна', 'вул. Мечникова'],
    'Харків': ['вул. Пушкінська', 'вул. Сумська', 'вул. Полтавський Шлях', 'вул. Гімназійна набережна'],
    'Ізюм': ['вул. Київська', 'вул. Першотравнева'],
    'Лозова': ['вул. Соборна', 'вул. Шевченка'],
    'Одеса': ['вул. Дерибасівська', 'вул. Пушкінська', 'вул. Преображенська'],
    'Дніпро': ['просп. Яворницького', 'вул. Робоча', 'вул. Калинова'],
    'Запоріжжя': ['вул. Перемоги', 'вул. Гагаріна', 'вул. Чарівна'],
    'Вінниця': ['вул. Соборна', 'вул. Київська', 'вул. Пирогова'],
    'Полтава': ['вул. Європейська', 'вул. Шевченка', 'вул. Соборності'],
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
