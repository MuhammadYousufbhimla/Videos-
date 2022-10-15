import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; //add pacakge to pubspec.yaml

void main() {
  runApp(
    MaterialApp(
      home: _App(),
    ),
  );
}

// List<String> videos = [
//   'https://archive.org/download/SampleVideo1280x7205mb/SampleVideo_1280x720_5mb.mp4',
//   'https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_640_3MG.mp4',
//   'https://filesamples.com/samples/video/mp4/sample_640x360.mp4'
// ];
List<String> videos = [
        'assets/Chalchal.mp4',
        'assets/Video2.mp4',
];

class _App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text( 'Bayan'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            VideoPlayerRemote(
              url: videos[0],
            ),
             VideoPlayerRemote(
              url: videos[1],
            ),
          
         
          ],
        ),
      ),
    );
  }
}

//video code

class VideoPlayerRemote extends StatefulWidget {
  final String url;
  VideoPlayerRemote({ required this.url});
  @override
  _VideoPlayerRemoteState createState() => _VideoPlayerRemoteState();
}

class _VideoPlayerRemoteState extends State<VideoPlayerRemote> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      widget.url, //to access its parent class constructor or variable
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true); //loop through video
    _controller.initialize(); //initialize the VideoPlayer
  }

  @override
  void dispose() {
    _controller.dispose(); //dispose the VideoPlayer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(padding: const EdgeInsets.only(top: 15.0)),
          Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 198, 125, 211),
            borderRadius: BorderRadius.circular(20),
          ),
           
            padding: const EdgeInsets.all(10),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({ required this.controller}) ;

  final VideoPlayerController controller;





  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
       switchOutCurve:  Curves.linear,
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child:
                     Icon(   
                    controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 80.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            // pause
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              // play
              controller.play();
            }
          },
        ),
      
      ],
    );
  }
}