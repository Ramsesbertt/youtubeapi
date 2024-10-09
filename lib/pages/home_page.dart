import 'package:flutter/material.dart';
import 'package:youtube_api/services/youtube_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Video>> _trendingVideos;
  final YouTubeApiService _youtubeApiService = YouTubeApiService();

  @override
  void initState() {
    super.initState();
    _trendingVideos = _youtubeApiService.fetchTrendingVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262526),
      appBar: AppBar(
        backgroundColor: const Color(0xFF262526),
        title: Image.asset('assets/images/YouTube.png', width: 100),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            radius: 15,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryBar(),
          Expanded(
            child: FutureBuilder<List<Video>>(
              future: _trendingVideos,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar los videos.'));
                } else {
                  final videos = snapshot.data!;
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final video = videos[index];
                      return ListTile(
                        leading: Image.network(video.thumbnailUrl),
                        title: Text(video.title, style: const TextStyle(color: Colors.white)),
                        subtitle: Text(video.channelTitle, style: const TextStyle(color: Colors.grey)),
                        onTap: () {
                          // Aquí podrías navegar a la página de detalle de cada video.
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(), backgroundColor: Colors.white24,
            ),
            onPressed: () {},
            icon: const Icon(Icons.explore, color: Color.fromARGB(255, 255, 249, 249)),
            label: const Text('Explorar', style: TextStyle(color: Colors.white)),
          ),
          const VerticalDivider(color: Colors.grey),
          TextButton(
            onPressed: () {},
            child: const Text('Todos', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Mixes', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Principales', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

