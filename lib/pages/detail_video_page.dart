import 'package:flutter/material.dart';
import 'package:youtube_api/services/youtube_api_service.dart';
import 'package:youtube_api/services/youtube_comments_service.dart'; // Importa el servicio de comentarios
import 'package:intl/intl.dart'; // Para formatear el número de vistas
import 'package:youtube_api/models/comments_page.dart'; // Importa el modelo de comentarios

class DetailVideoPage extends StatefulWidget {
  final Video video;

  const DetailVideoPage({Key? key, required this.video}) : super(key: key);

  @override
  _DetailVideoPageState createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage> {
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _fetchComments();
  }

  Future<List<Comment>> _fetchComments() async {
  try {
    final commentsService = YouTubeCommentsService(
      apiKey: 'AIzaSyBZOCjuwGfWTeeEx0aEZk3U6w7cr-YJHaA', // Reemplaza con tu API Key
      videoId: widget.video.id, // Asegúrate de que este es el ID del video
    );
    return await commentsService.fetchComments();
  } catch (e) {
    print('Error al cargar comentarios: $e'); // Imprime el error
    rethrow; // Relanza el error para que el FutureBuilder lo maneje
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del Video"),
        backgroundColor: const Color(0xFF262526),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video player placeholder
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: Text(
                  "Video Player Here",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Video title
            Text(
              widget.video.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            // Views and published date
            Row(
              children: [
                Text(
                  "${_formatViews(widget.video.viewCount)} de vistas",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 16.0),
                Text(
                  _timeAgo(widget.video.publishedAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Channel info in one line
            Row(
              children: [
                // Channel image
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.video.thumbnailUrl),
                  radius: 20,
                ),
                const SizedBox(width: 8.0),
                // Channel name and subscriber count in one line
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        widget.video.channelTitle,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "33.2 M suscriptores",
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Action buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildOvalButton(Icons.thumb_up, "2.5 K"),
                  _buildDivider(),
                  _buildOvalButton(Icons.thumb_down, ""),
                  _buildDivider(),
                  _buildOvalButton(Icons.share, "Compartir"),
                  _buildDivider(),
                  _buildOvalButton(Icons.block, "Detener anuncio"),
                  _buildDivider(),
                  _buildOvalButton(Icons.cut, "Recortar"),
                  _buildDivider(),
                  _buildOvalButton(Icons.bookmark, "Guardar"),
                  _buildDivider(),
                  _buildOvalButton(Icons.flag, "Denunciar"),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Comments section
            Text(
              "Comentarios:",
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: FutureBuilder<List<Comment>>(
                future: _commentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error al cargar comentarios"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No hay comentarios"));
                  } else {
                    return ListView(
                      children: snapshot.data!.map((comment) => _buildCommentItem(comment)).toList(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF262526),
    );
  }

  // Existing methods below...

  // Build each comment item
  Widget _buildCommentItem(Comment comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Profile image
          CircleAvatar(
            backgroundImage: NetworkImage(comment.profileImageUrl),
            radius: 20,
          ),
          const SizedBox(width: 8.0),
          // Comment text and like count
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.text,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 4.0),
                Text(
                  "${comment.likeCount} Me gusta",
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Button builder and other existing methods...

  String _formatViews(int viewCount) {
    if (viewCount >= 1000000) {
      return "${(viewCount / 1000000).toStringAsFixed(1)} M";
    } else if (viewCount >= 1000) {
      return "${(viewCount / 1000).toStringAsFixed(1)} K";
    } else {
      return viewCount.toString();
    }
  }

  String _timeAgo(String publishedAt) {
    final DateTime publishDate = DateTime.parse(publishedAt);
    final Duration diff = DateTime.now().difference(publishDate);

    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} años";
    } else if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} meses";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} días";
    } else if (diff.inHours > 0) {
      return "${diff.inHours} horas";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes} minutos";
    } else {
      return "hace un momento";
    }
  }

  Widget _buildOvalButton(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(width: 12);
  }
}



