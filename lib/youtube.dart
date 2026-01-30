import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// mobile
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as mobile;

// web
import 'package:youtube_player_iframe/youtube_player_iframe.dart' as web;

class YoutubeApp extends StatelessWidget {
  const YoutubeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('YouTube Multi Platform')),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: const [
          YoutubePlayerView(videoId: 'AL1pDdk8R40'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class YoutubePlayerView extends StatelessWidget {
  final String videoId;

  const YoutubePlayerView({
    super.key,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebYoutubePlayer(videoId: videoId);
    } else {
      return MobileYoutubePlayer(videoId: videoId);
    }
  }
}

class MobileYoutubePlayer extends StatefulWidget {
  final String videoId;

  const MobileYoutubePlayer({
    super.key,
    required this.videoId,
  });

  @override
  State<MobileYoutubePlayer> createState() => _MobileYoutubePlayerState();
}

class _MobileYoutubePlayerState extends State<MobileYoutubePlayer> {
  late mobile.YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = mobile.YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const mobile.YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mobile.YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
    );
  }
}

class WebYoutubePlayer extends StatefulWidget {
  final String videoId;

  const WebYoutubePlayer({
    super.key,
    required this.videoId,
  });

  @override
  State<WebYoutubePlayer> createState() => _WebYoutubePlayerState();
}

class _WebYoutubePlayerState extends State<WebYoutubePlayer> {
  late web.YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = web.YoutubePlayerController(
      params: const web.YoutubePlayerParams(
        showControls: true,
        enableCaption: true,
      ),
    )..loadVideoById(videoId: widget.videoId);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return web.YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
