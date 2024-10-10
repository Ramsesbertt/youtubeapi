// lib/services/youtube_comments_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_api/models/comments_page.dart';

class YouTubeCommentsService {
  final String apiKey;
  final String videoId;

  YouTubeCommentsService({required this.apiKey, required this.videoId});

  Future<List<Comment>> fetchComments() async {
    final url = 'https://youtube.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=$videoId&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    // Verificar el estado de la respuesta
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['items'] as List)
          .map((item) => Comment(
                profileImageUrl: item['snippet']['topLevelComment']['snippet']['authorProfileImageUrl'],
                text: item['snippet']['topLevelComment']['snippet']['textDisplay'],
                likeCount: item['snippet']['topLevelComment']['snippet']['likeCount'] ?? 0,
              ))
          .toList();
    } else {
      print('Error: ${response.statusCode} - ${response.body}'); // Añade esto para depurar
      throw Exception('Failed to load comments');
    }
  }
}

