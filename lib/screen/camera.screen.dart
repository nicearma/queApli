// Ensure that plugin services are initialized so that `availableCameras()`
// can be called before `runApp()`
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> haveCameras() async {
  final cameras = await availableCameras();
  return cameras.length > 0;
}

Future<CameraDescription> getFirstCamera() async {
  final cameras = await availableCameras();
  return cameras.first;
}

Future<CameraDescription> getNextCamera(CameraDescription currentCamera) async {
  final cameras = await availableCameras();

  var indexOfCurrentCamera = cameras.indexOf(currentCamera);

  if (indexOfCurrentCamera > cameras.length - 1) {
    return cameras.first;
  }

  return cameras[indexOfCurrentCamera + 1];
}

// A screen that allows users to take a picture using a given camera.
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key key,
  }) : super(key: key);

  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {

    super.initState();
    chargeCamera();
  }


  chargeCamera() async {

    var firstCamera = await getFirstCamera();

    setState(() {
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.medium,
      );

      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();
    });

  }


  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
            final path = join(
              // Store the picture in the temp directory.
              // Find the temp directory using the `path_provider` plugin.
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}