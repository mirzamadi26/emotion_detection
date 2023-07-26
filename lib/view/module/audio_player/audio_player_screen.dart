// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/app_logo.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({Key? key}) : super(key: key);

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  // final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text: "Audio Player",
            size: 20,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: AppColor.greenColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customImage(image: AppLogo.appLogo, height: 150, width: 150),
            customTextAlignCenter(
                text: "Title",
                size: 15,
                color: AppColor.greenColor,
                fontWeight: FontWeight.bold),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customTextAlignCenter(
                    text: "",
                    size: 15,
                    color: AppColor.greenColor,
                    fontWeight: FontWeight.bold),
              ],
            )
          ],
        ),
      ),
    );
  }
}
