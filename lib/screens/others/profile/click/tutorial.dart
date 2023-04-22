import 'package:flutter/material.dart';
import 'package:tasc/theme/theme.dart';
import 'package:video_player/video_player.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  late VideoPlayerController controller;
  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  loadVideoPlayer() {
    controller = VideoPlayerController.asset("assets/images/tutorial.mp4");
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heres a quick Tutorial"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(controller),
            ),
          ),
          VideoProgressIndicator(controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                backgroundColor: Colors.blueAccent,
                playedColor: preprimClr,
                bufferedColor: Colors.black,
              )),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }

                    setState(() {});
                  },
                  icon: Icon(controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow)),
              IconButton(
                onPressed: () {
                  controller.seekTo(Duration(seconds: 0));
                  setState(() {});
                },
                icon: Icon(Icons.stop),
              )
            ],
          )
        ],
      ),
    );
  }
}
