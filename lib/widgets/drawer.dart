import 'package:final_project/providers/news_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsDrawer extends StatefulWidget {
  const NewsDrawer({super.key});

  @override
  State<NewsDrawer> createState() => _NewsDrawerState();
}

class _NewsDrawerState extends State<NewsDrawer> {
  final List<String> countries = ['us', 'au', 'mx', 'ae', 've', 'il', 'id'];
  
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  final List<String> channels = ['BBC News', 'Times of India', 'Politico', 'The Washington Post', 'Reuters', 'CNN', 'NBC NEWS', 'The Hills', 'FOX News'];
  
  // final List<String> channels = [
  //   'bbc-news',
  //   'cnn',
  //   'fox-news',
  //   'the-washington-post',
  //   'times-of-india'
  // ];

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 4, 78, 114)),
            child: Text('Filters', style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            title: const Text('Select Country'),
            trailing: DropdownButton<String>(
              value: newsProvider.selectedCountry,
              onChanged: (value) {
                newsProvider.updateFilters(country: value);
                newsProvider.fetchNews();
                Navigator.pop(context);
              },
              items: countries.map((country) {
                return DropdownMenuItem(
                  value: country,
                  child: Text(country.toUpperCase()),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Select Category'),
            trailing: DropdownButton<String>(
              value: newsProvider.selectedCategory,
              onChanged: (value) {
                newsProvider.updateFilters(category: value);
                newsProvider.fetchNews();
                Navigator.pop(context);
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.capitalize()),
                );
              }).toList(),
            ),
          ),
          ListTile(
            title: const Text('Select Channel'),
            trailing: DropdownButton<String>(
              value: newsProvider.selectedChannel.isEmpty
                  ? null
                  : newsProvider.selectedChannel,
              hint: const Text('All'),
              onChanged: (value) {
                newsProvider.updateFilters(channel: value ?? '');
                newsProvider.fetchNews();
                Navigator.pop(context);
              },
              items: [
               const DropdownMenuItem(value: '', child: Text('All')),
                ...channels.map((channel) {
                  return DropdownMenuItem(
                    value: channel,
                    child: Text(channel.capitalize()),
                  );
                }).toList()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}
