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
            // Channel info
            Row(
              children: [
                // Channel image
                CircleAvatar(
                  backgroundImage: NetworkImage(video.thumbnailUrl), // Assuming thumbnailUrl is the channel image
                  radius: 20,
                ),
                const SizedBox(width: 8.0),
                // Channel name and subscriber count
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.channelTitle,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      "33.2 M", // Placeholder for subscriber count, you can add a property for subscribers in Video
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF262526),
    );
  }

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
}
