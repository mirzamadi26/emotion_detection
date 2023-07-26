import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../constant/app_color/app_color.dart';
import '../../../../../controller/data_controller.dart';
import '../../../../widget/custom_text.dart';

class WatchVideoScreen extends StatefulWidget {
  const WatchVideoScreen({Key? key}) : super(key: key);

  @override
  State<WatchVideoScreen> createState() => _WatchVideoScreenState();
}

class _WatchVideoScreenState extends State<WatchVideoScreen> {
  late DataController dataController;
  late YoutubePlayerController youtubePlayerController;

  @override
  void initState() {
    try {
      dataController = Get.find();
    } catch (exception) {
      dataController = Get.put(DataController());
    }
    String url =
        dataController.dataModel[dataController.resultIndex].video!.trim();
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: false,
          autoPlay: true,
        ))
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    super.initState();
  }

  @override
  void deactivate() {
    youtubePlayerController.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: youtubePlayerController,
      ),
      builder: (context, player) => Scaffold(
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
                    colors: <Color>[AppColor.chinesePurpleColor, AppColor.crayolaColor])),
          ),
          elevation: 0,
        ),
        body: Center(child: player),
      ),
    );
  }
}
