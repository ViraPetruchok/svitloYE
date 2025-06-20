import 'dart:async';
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
  Timer? _timer;

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(
          'https://corsproxy.io/?url=https://rsshub.app/telegram/channel/Ukrenergo'));
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

    // Автоматичне оновлення кожні 5 хвилин
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      fetchNews();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _showNewsDialog(RssItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          item.title ?? 'Без назви',
          style: const TextStyle(color: Colors.yellow),
        ),
        content: SingleChildScrollView(
          child: Text(
            item.description ?? 'Немає опису',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Закрити', style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
          : _items.isEmpty
              ? const Center(
                  child: Text(
                    'Немає новин',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: fetchNews,
                  color: Colors.yellow,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(color: Colors.grey),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          item.title ?? 'Без назви',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: item.pubDate != null
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  item.pubDate!,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                              )
                            : null,
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: Colors.yellow, size: 16),
                        onTap: () => _showNewsDialog(item),
                      );
                    },
                  ),
                ),
    );
  }
}
