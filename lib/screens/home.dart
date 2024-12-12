import 'package:final_project/providers/news_provider.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ini adalah snackbar"))
                );
              }, 
              icon: const Icon(Icons.toggle_off_sharp, color: Colors.white),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 4, 78, 114),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Top News'),
        titleTextStyle: const TextStyle(
            color: Colors.white, // Warna teks di AppBar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        centerTitle: true,
      ),
      drawer: const NewsDrawer(),
      body: FutureBuilder(
        future: newsProvider.fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(
                child: Text(
                  'cannot process data!!',
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            } else {

            return Consumer<NewsProvider>(
              builder: (BuildContext context, NewsProvider value, Widget? child) { 
              return ListView.builder(
                itemCount: newsProvider.newsList.length,
                itemBuilder: (context, index) {
                  final news = newsProvider.newsList[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (news.urlToImage.isNotEmpty)
                          Image.network(
                            news.urlToImage,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news.title,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            news.description,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        ListTile(
                            onTap: () {
                            // Handle article tap
                          },
                        )
                      ],
                    ),
                  );
                },
              );
              },
            );
            }
          }
        },
      ),
    );
  }
}