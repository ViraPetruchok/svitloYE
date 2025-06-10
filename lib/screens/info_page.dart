import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  // Функція для відкриття URL
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Не вдається відкрити $url';
    }
  }

  // Функція для відкриття поштової програми для написання відгуку
  Future<void> _sendFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kkv2896@gmail.com',
      queryParameters: {
        'subject': 'Відгук про додаток SvitloYe',
      },
    );
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Не вдалося відкрити поштовий клієнт для відгуку';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SvitloYe',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Цей додаток допомагає відстежувати відключення світла в Україні.\n'
              'На карті можна переглянути стан світла по регіонах.\n'
              'Ви також можете отримувати актуальні новини та інформацію про планові відключення.\n'
              'Зручний інтерфейс дозволяє швидко дізнаватися про стан електропостачання у вашому регіоні.',
              style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            const SizedBox(height: 24),
            const Text(
              'Про розробника:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            const Text(
              'Розроблено студенткою ІТ-напряму з України, яка прагне покращити інформування громадян про відключення електроенергії в умовах воєнного часу. Цей додаток створено з метою забезпечення швидкого доступу до актуальної інформації про стан електропостачання в регіонах України.',
              style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            const SizedBox(height: 24),
            const Text(
              'Контакти:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            const Text(
              'Пошта: kkv2896@gmail.com\n',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Text(
              'Номер телефону: +380930426736',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Дякую ЗСУ за можливість створювати',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text(
              'Версія 1.0.0 (beta)',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 24),
            const Text(
              'Підтримуйте мене в соцмережах:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.github, color: Colors.white),
                  onPressed: () => _launchURL('https://github.com/ViraPetruchok'),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.instagram, color: Colors.white),
                  onPressed: () => _launchURL('https://www.instagram.com/petruchok.vira/'),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.linkedin, color: Colors.white),
                  onPressed: () => _launchURL('https://www.linkedin.com/in/vira-petruchok/'),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
