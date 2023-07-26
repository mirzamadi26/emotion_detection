import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:therapyx/view/module/auth/login_screen.dart';
import 'package:video_player/video_player.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation.dart';
import '../../../constant/assets_path/app_logo.dart';
import '../../../controller/data_controller.dart';
import '../../widget/about_project.dart';
import '../../widget/custom_icon.dart';
import '../../widget/custom_image.dart';
import '../../widget/custom_text.dart';
import '../predict/predict_screen.dart';
import '../result/result_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataController dataController;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;

  @override
  void initState() {
    try {
      dataController = Get.find();
    } catch (exception) {
      dataController = Get.put(DataController());
    }
    _videoController = VideoPlayerController.asset(
      'assets/animation/video.mp4',
    );

    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      aspectRatio: 16 / 9,
      looping: true,
      // Other customization options can be added here
    );

    _initializeVideo().then((_) {
      setState(() {});
    });

    super.initState();
  }

  Widget _buildVideoPlayer() {
    if (_chewieController != null &&
        _chewieController.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController);
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();
      _chewieController.play();
    } catch (e) {
      print("Error occurred during video initialization: $e");
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return GetBuilder<DataController>(
        builder: (dataController) => Scaffold(
              backgroundColor: AppColor.primaryColor,
              key: scaffoldKey,
              appBar: AppBar(
                actions: [
                  TextButton.icon(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          print("User logged out successfully.");
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                              (route) => false);
                        } catch (e) {
                          print("Error occurred during logout: $e");
                        }
                      },
                      icon: Icon(
                        Icons.logout,
                        color: AppColor.primaryColor,
                      ),
                      label: Text(
                        "Log out",
                        style: TextStyle(color: AppColor.primaryColor),
                      ))
                ],
                leading: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => scaffoldKey.currentState!.openDrawer(),
                    child: customIcon(
                        icon: Icons.menu,
                        color: AppColor.primaryColor,
                        size: 20)),
                title: customTextAlignCenter(
                    text: "Welcome",
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
              drawer: Drawer(
                backgroundColor: AppColor.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customLogo(
                          image: AppLogo.appLogo, height: 100, width: 200),
                      Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 3,
                        color: AppColor.greenColor,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Get.to(() => AboutProject());
                          },
                          child: Center(
                            child: customTextAlignCenter(
                                text: "About",
                                size: 20,
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          height: Get.height * 0.28,
                          width: Get.width,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: _buildVideoPlayer(),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          dataController.pickImageFromGallery();
                          Get.to(() => const ResultScreen());
                        },
                        child: Container(
                          height: Get.height * 0.25,
                          width: Get.width,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColor.crayolaColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                    'assets/animation/imagepicker.json',
                                    width: s.width * 0.4,
                                    height: s.height * 0.2,
                                    reverse: true),
                                SizedBox(
                                  height: 5,
                                ),
                                customTextAlignCenter(
                                    text: "Select Image From Gallery",
                                    size: 15,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          Get.to(() => PredictScreen());
                        },
                        child: Container(
                          height: Get.height * 0.25,
                          width: Get.width,
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: AppColor.amberAccentColor.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/animation/camera.json',
                                    width: s.width * 0.4,
                                    height: s.height * 0.2,
                                    reverse: true),
                                SizedBox(
                                  height: 5,
                                ),
                                customTextAlignCenter(
                                    text: "Predict",
                                    size: 15,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.bold),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
