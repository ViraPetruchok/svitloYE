import 'package:flutter/material.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<RssItem> _items = [];
  bool _isLoading = true;

  Future<void> fetchNews() async {
  try {
    final response = await http.get(Uri.parse('https://rsshub.app/telegram/channel/lvivoblenergo'));
    print("Статус код відповіді: ${response.statusCode}");
    if (response.statusCode == 200) {
      final rssFeed = RssFeed.parse(response.body);
      setState(() {
        _items = rssFeed.items;
        _isLoading = false;
      });
    } else {
      throw Exception('Помилка завантаження RSS: ${response.statusCode}');
    }
  } catch (e) {
    print('Помилка: $e');
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
          : _items.isEmpty
              ? const Center(child: Text('Немає новин', style: TextStyle(color: Colors.white)))
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return ListTile(
                      title: Text(item.title ?? '',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text(item.pubDate ?? '',
                          style: const TextStyle(color: Colors.white60)),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: Colors.grey[900],
                            title: Text(item.title ?? '',
                                style: const TextStyle(color: Colors.yellow)),
                            content: SingleChildScrollView(
                              child: Text(item.description ?? '',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Закрити', style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
