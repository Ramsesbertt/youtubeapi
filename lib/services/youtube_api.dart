import 'package:http/http.dart' as http;
import 'dart:convert';

class YouTubeApi {
  final String _apiKey = 'AIzaSyBZOCjuwGfWTeeEx0aEZk3U6w7cr-YJHaA'; // Inserta aquí tu clave de API

  Future<List<dynamic>> fetchVideos(String query) async {
    final url = Uri.parse(
      'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&type=video&key=$_apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['items'];
    } else {
      throw Exception('Error al obtener videos de YouTube');
    }
  }
}
