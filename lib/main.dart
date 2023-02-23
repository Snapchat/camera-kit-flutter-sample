import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Uint8List _imagePath = Uint8List.fromList([]);
  bool _isImageAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _isImageAvailable
                ? Image.memory(_imagePath)
                : Image.network('https://picsum.photos/200/300'),
          ],
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
    final Uint8List? result =
        await platform.invokeMethod('openCameraKitLenses');
    setState(() {
      _isImageAvailable = true;
      _imagePath = result!;
    });
  }
}
