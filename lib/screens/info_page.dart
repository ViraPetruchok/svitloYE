import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Не вдається відкрити $url';
    }
  }

  Future<void> _sendFeedback() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'kkv2896@gmail.com',
      queryParameters: {'subject': 'Відгук про додаток SvitloYe'},
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Не вдалося відкрити поштовий клієнт';
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
              'Застосунок для відстеження відключень світла в Україні. Доступ до карти, новин та іноформувань про відключення — у зручному та зрозумілому інтерфейсі.',
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Розробниця:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            const Text(
              'Віра Петручок — студентка ІТ-напряму з України, яка прагне покращити доступ до важливої інформації в умовах воєнного часу.',
              style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            const Text(
              'Технічна підтримка:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            const Text(
              'Якщо ви зіткнулися з проблемою або хочете залишити відгук — напишіть на пошту або в соцмережі нижче.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.email, color: Colors.yellow),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendFeedback,
                  child: const Text(
                    'kkv2896@gmail.com',
                    style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone_android, color: Colors.yellow),
                const SizedBox(width: 8),
                const Text(
                  '+380930426736',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Підтримайте розробницю в соцмережах:',
              style: TextStyle(color: Colors.yellow, fontSize: 20),
            ),
            const SizedBox(height: 12),
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
            const SizedBox(height: 32),
            const Center(
              child: Text(
                'Версія 1.0.0 (beta)\nДякую ЗСУ за можливість розвивати проєкти',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
