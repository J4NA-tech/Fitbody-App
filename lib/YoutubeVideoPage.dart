import 'package:flutter/material.dart';
// YoutubePlayer Flutter paketi, YouTube videolarını Flutter içinde oynatmanı sağlar.
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// YoutubeVideoPage adında bir sayfa (stateful widget) oluşturduk.
/// Bu sayfa, bir video ID alarak YouTube videosunu oynatır.
class YoutubeVideoPage extends StatefulWidget {
  final String videoId; // YouTube video ID'si örnek: 'n_cIBBDb9JA'

  const YoutubeVideoPage({Key? key, required this.videoId}) : super(key: key);

  @override
  _YoutubeVideoPageState createState() => _YoutubeVideoPageState();
}

class _YoutubeVideoPageState extends State<YoutubeVideoPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    // YouTube video oynatıcısı başlatılıyor
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId, // widget’tan gelen video ID
      flags: YoutubePlayerFlags(
        autoPlay: true, // Sayfa açılır açılmaz video oynatılır
        mute: false,    // Ses açık
      ),
    );
  }

  @override
  void dispose() {
    // Sayfa kapatıldığında controller temizlenir
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Arka plan siyah
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Video'), // Uygulamanın üst kısmında "Video" başlığı
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true, // İlerleme çubuğu göster
      ),
    );
  }
}
