import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String videoId;
  final String title;

  const DetailPage({Key? key, required this.videoId, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF262526),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Redirigir a YouTube para ver el video
                final url = 'https://www.youtube.com/watch?v=$videoId';
                // Implementar un webview o redireccionar al navegador
              },
              child: const Text('Ver Video'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF262526),
    );
  }
}



