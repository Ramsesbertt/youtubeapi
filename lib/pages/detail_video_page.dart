import 'package:flutter/material.dart';
import 'package:youtube_api/services/youtube_api_service.dart';
import 'package:intl/intl.dart'; // Para formatear el número de vistas

class DetailVideoPage extends StatelessWidget {
  final Video video;

  const DetailVideoPage({Key? key, required this.video}) : super(key: key);

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
              video.title,
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
                  "${_formatViews(video.viewCount)} de vistas",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 16.0),
                Text(
                  _timeAgo(video.publishedAt),
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
                  backgroundImage: NetworkImage(video.thumbnailUrl), // Assuming thumbnailUrl is the channel image
                  radius: 20,
                ),
                const SizedBox(width: 8.0),
                // Channel name and subscriber count in one line
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        video.channelTitle,
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "33.2 M suscriptores", // Placeholder for subscriber count
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // Action buttons: like, dislike, share, etc.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildOvalButton(Icons.thumb_up, "2.5 K"), // Likes
                  _buildDivider(),
                  _buildOvalButton(Icons.thumb_down, ""), // Dislike
                  _buildDivider(),
                  _buildOvalButton(Icons.share, "Compartir"), // Share
                  _buildDivider(),
                  _buildOvalButton(Icons.block, "Detener anuncio"), // Stop Ad
                  _buildDivider(),
                  _buildOvalButton(Icons.cut, "Recortar"), // Clip
                  _buildDivider(),
                  _buildOvalButton(Icons.bookmark, "Guardar"), // Save
                  _buildDivider(),
                  _buildOvalButton(Icons.flag, "Denunciar"), // Report
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF262526),
    );
  }

  // Button builder with icon and text inside an oval
  Widget _buildOvalButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                if (label.isNotEmpty) ...[
                  const SizedBox(width: 8.0),
                  Text(label, style: const TextStyle(color: Colors.white)),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Divider between the buttons
  Widget _buildDivider() {
    return const SizedBox(width: 8.0);
  }

  // Format the views with "K" for thousands and "M" for millions
  String _formatViews(int viewCount) {
    if (viewCount >= 1000000) {
      return "${(viewCount / 1000000).toStringAsFixed(1)} M";
    } else if (viewCount >= 1000) {
      return "${(viewCount / 1000).toStringAsFixed(1)} K";
    } else {
      return viewCount.toString();
    }
  }

  // Calculate how long ago the video was published
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
}


