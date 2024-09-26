import 'package:flutter/material.dart';
import '../services/youtube_api.dart'; // Lógica de la API
import 'detail_page.dart'; // Página de detalles

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final YouTubeApi youtubeApi = YouTubeApi(); // Instancia de la API
  List<dynamic> videos = [];

  // Método para buscar videos
  void searchVideos(String query) async {
    try {
      final fetchedVideos = await youtubeApi.fetchVideos(query);
      setState(() {
        videos = fetchedVideos;
      });
    } catch (e) {
      print('Error al buscar videos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF262526), // Fondo gris oscuro
      appBar: AppBar(
        backgroundColor: const Color(0xFF262526),
        elevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: SizedBox(
            width: 80, // Tamaño ajustado del logo (mediano)
            height: 40,
            child: Image.asset('assets/images/YouTube.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cast, color: Colors.white), // Icono blanco
            onPressed: () {
              // Acción para conectar con dispositivos Smart TV
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white), // Icono blanco
            onPressed: () {
              // Acción para notificaciones
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Icono blanco
            onPressed: () {
              // Acción para búsqueda
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_profile.png'), // Foto de perfil del usuario
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Barra de navegación inferior (Explorar, Todos, Mixes, Principales)
            Container(
              color: const Color(0xFF262526),
              padding: const EdgeInsets.symmetric(vertical: 10), // Espaciado
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Botón Explorar (con forma de eclipse)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        // Acción para el botón de explorar
                      },
                      icon: const Icon(Icons.explore, color: Colors.white),
                      label: const Text('Explorar', style: TextStyle(color: Colors.white)),
                    ),
                  ),

                  const VerticalDivider(color: Colors.white), // Separador vertical

                  // Botón Todos (con forma rectangular)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Acción para el botón de todos
                      },
                      child: const Text('Todos', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const VerticalDivider(color: Colors.white), // Separador vertical

                  // Botón Mixes (con forma rectangular)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Acción para el botón de mixes
                      },
                      child: const Text('Mixes', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const VerticalDivider(color: Colors.white), // Separador vertical

                  // Botón Principales (con forma rectangular)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Acción para el botón de principales
                      },
                      child: const Text('Principales', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Botón para buscar videos de ejemplo
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                searchVideos('Flutter'); // Buscar videos de Flutter
              },
              child: const Text('Buscar videos de Flutter'),
            ),
            const SizedBox(height: 10),
            // Lista de videos obtenidos desde la API
            Expanded(
              child: videos.isEmpty
                  ? const Center(
                      child: Text('No se encontraron videos', style: TextStyle(color: Colors.white)),
                    )
                  : ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return ListTile(
                          leading: Image.network(video['snippet']['thumbnails']['default']['url']),
                          title: Text(
                            video['snippet']['title'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            video['snippet']['channelTitle'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            // Acción para ver detalles del video o reproducir
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  videoId: video['id']['videoId'],
                                  title: video['snippet']['title'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
