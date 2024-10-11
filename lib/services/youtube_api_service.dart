import 'dart:convert';
import 'package:http/http.dart' as http;

class YouTubeApiService {
  final String apiKey = 'AIzaSyBZOCjuwGfWTeeEx0aEZk3U6w7cr-YJHaA';
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
  final String channelThumbnailUrl;
  final int viewCount;
  final String publishedAt;
  final int subscriberCount;

  Video({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.channelThumbnailUrl,
    required this.viewCount,
    required this.publishedAt,
    required this.subscriberCount,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['snippet']['channelTitle'],
      channelThumbnailUrl: json['snippet']['thumbnails']['default'] != null 
        ? json['snippet']['thumbnails']['default']['url'] 
        : 'URL_DE_IMAGEN_POR_DEFECTO',
      viewCount: json['statistics']['viewCount'] != null
          ? int.parse(json['statistics']['viewCount'])
          : 0,
      publishedAt: json['snippet']['publishedAt'] ?? '',
      subscriberCount: json['statistics']['subscriberCount'] != null
          ? int.parse(json['statistics']['subscriberCount'])
          : 0,
    );
  }
}





