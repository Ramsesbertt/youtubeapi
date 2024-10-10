import 'package:flutter/material.dart';
import 'package:youtube_api/services/youtube_api_service.dart';
import 'package:intl/intl.dart'; // Asegúrate de que este paquete esté en tu pubspec.yaml
import 'detail_video_page.dart'; // Importa la página de detalles

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
                      return GestureDetector(
                        onTap: () {
                          // Navega a la página de detalles del video
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailVideoPage(video: video),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Video thumbnail
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(video.thumbnailUrl, fit: BoxFit.cover),
                              ),
                              const SizedBox(height: 5),
                              // Título del video
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  video.title,
                                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Información del canal, vistas y tiempo
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Imagen del canal
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(video.channelThumbnailUrl),
                                    radius: 15,
                                  ),
                                  const SizedBox(width: 8), // Espacio entre la imagen del canal y el nombre
                                  // Nombre del canal y detalles
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        // Nombre del canal
                                        Text(
                                          video.channelTitle,
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(width: 8), // Espacio entre el nombre del canal y el texto de vistas/tiempo
                                        // Vistas y tiempo
                                        Text(
                                          '${NumberFormat.compact().format(video.viewCount)} vistas - ${_timeAgo(video.publishedAt)}',
                                          style: const TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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

  String _timeAgo(String publishedAt) {
    final dateTime = DateTime.parse(publishedAt);
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays >= 365) {
      return '${(difference.inDays / 365).floor()} años';
    } else if (difference.inDays >= 30) {
      return '${(difference.inDays / 30).floor()} meses';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} días';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} horas';
    } else {
      return '${difference.inMinutes} minutos';
    }
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



