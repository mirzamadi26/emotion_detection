// import 'package:audioplars/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';ye
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_color/app_color.dart';
import '../../../../../controller/data_controller.dart';
import '../../../../widget/custom_text.dart';

class ListenAudioScreen extends StatefulWidget {
  const ListenAudioScreen({Key? key}) : super(key: key);

  @override
  State<ListenAudioScreen> createState() => _ListenAudioScreenState();
}

class _ListenAudioScreenState extends State<ListenAudioScreen> {
  late DataController dataController;
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    try {
      dataController = Get.find();
    } catch (exception) {
      dataController = Get.put(DataController());
    }
    audioPlayer.onDurationChanged.listen((durationValue) {
      setState(() {
        duration = durationValue;
      });
    });
    audioPlayer.onPositionChanged.listen((positionValue) {
      setState(() {
        position = positionValue;
      });
    });
    setAudio();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        title: customTextAlignCenter(
            text: dataController
                .dataModel[dataController.resultIndex].expression
                .toString(),
            size: 20,
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                AppColor.chinesePurpleColor,
                AppColor.crayolaColor
              ])),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              dataController.dataModel[dataController.resultIndex].image
                  .toString(),
              height: 200,
              width: 200,
              fit: BoxFit.fill,
            ),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final sliderPosition = Duration(seconds: value.toInt());
                  await audioPlayer.seek(sliderPosition);
                  await audioPlayer.resume();
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customTextAlignCenter(
                      text: position
                          .toString()
                          .substring(0, position.toString().indexOf(".")),
                      size: 15,
                      color: AppColor.chinesePurpleColor,
                      fontWeight: FontWeight.bold),
                  customTextAlignCenter(
                      text: duration
                          .toString()
                          .substring(0, duration.toString().indexOf(".")),
                      size: 15,
                      color: AppColor.chinesePurpleColor,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  color: isPlaying
                      ? AppColor.chinesePurpleColor
                      : AppColor.chinesePurpleColor,
                  borderRadius: BorderRadius.circular(50)),
              child: InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                    setState(() {
                      isPlaying = false;
                    });
                  } else {
                    await audioPlayer.resume();
                    setState(() {
                      isPlaying = true;
                    });
                  }
                },
                child: Center(
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 50,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    final player = AudioCache(prefix: "");
    final url = await player.load(
        dataController.dataModel[dataController.resultIndex].audio!.trim());
    await audioPlayer.setSourceUrl(url.path);
  }
}
