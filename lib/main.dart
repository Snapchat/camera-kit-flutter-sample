import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Camera Kit Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Flutter Camera Kit Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.camerakit.flutter.sample.simple');
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final List<Widget> _children = [
    Image.network('https://picsum.photos/200/300'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _children,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openCameraKitLenses,
        tooltip: 'Camera Kit',
        child: const Icon(Icons.camera),
      ),
    );
  }

  Future<void> _openCameraKitLenses() async {
    final result = await platform.invokeMethod('openCameraKitLenses');
    final String path = result['path'] as String;
    final String mimeType = result['mime_type'] as String;
    setState(() {
      _children.clear();
      if (mimeType == 'video') {
        _controller = VideoPlayerController.file(
          File(path),
        );
        initializeVideoPlayer();
        _children.add(
          Expanded(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      } else if (mimeType == 'image') {
        _children.add(
          Image.file(
            File(path),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void initializeVideoPlayer() {
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
