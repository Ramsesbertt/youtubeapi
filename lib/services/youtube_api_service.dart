import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeApiService {
  final String apiKey = 'AIzaSyBZOCjuwGfWTeeEx0aEZk3U6w7cr-YJHaA'; // Tu API Key aquí
  final String baseUrl = 'https://www.googleapis.com/youtube/v3';

  Future<List<Video>> fetchTrendingVideos() async {
    final url = Uri.parse(
        '$baseUrl/videos?part=snippet,statistics&chart=mostPopular&maxResults=10&regionCode=US&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List videos = data['items'];

      return videos.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los videos de tendencia.');
    }
  }
}

class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String channelThumbnailUrl; // Nueva propiedad para la imagen del canal
  final int viewCount; // Asegúrate de que esto sea un int
  final String publishedAt; // Fecha de publicación
  final int subscriberCount; // Nueva propiedad para el conteo de suscriptores

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.channelThumbnailUrl, // Nueva propiedad
    required this.viewCount, // Asegúrate de que esto sea un int
    required this.publishedAt, // Fecha de publicación
    required this.subscriberCount, // Nueva propiedad
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['snippet']['channelTitle'],
      channelThumbnailUrl: json['snippet']['thumbnails']['default'] != null 
        ? json['snippet']['thumbnails']['default']['url'] 
        : 'URL_DE_IMAGEN_POR_DEFECTO', // Reemplaza por una URL de imagen predeterminada
      viewCount: json['statistics']['viewCount'] != null
          ? int.parse(json['statistics']['viewCount']) // Asegúrate de que esto sea un int
          : 0,
      publishedAt: json['snippet']['publishedAt'] ?? '', // Asigna un valor vacío si no está presente
      subscriberCount: json['statistics']['subscriberCount'] != null
          ? int.parse(json['statistics']['subscriberCount']) // Asegúrate de que esto sea un int
          : 0,
    );
  }
}





