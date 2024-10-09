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
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(8.0),
                        color: const Color(0xFF1E1E1E), // Color de fondo del contenedor
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Imagen del video
                            Image.network(
                              video.thumbnailUrl,
                              width: double.infinity, // Toma todo el ancho disponible
                              height: 200, // Ajusta la altura según sea necesario
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Imagen de perfil del canal
                                CircleAvatar(
                                  backgroundImage: NetworkImage(video.thumbnailUrl),
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                // Título y nombre del canal
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Título del video
                                      Text(
                                        video.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 5),
                                      // Nombre del canal
                                      Text(
                                        video.channelTitle,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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

