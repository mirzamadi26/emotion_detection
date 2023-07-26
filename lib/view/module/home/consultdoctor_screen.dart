import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../constant/app_color/app_color.dart';
import '../../../constant/assets_path/animation.dart';
import '../../widget/custom_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsultDoctor extends StatefulWidget {
  const ConsultDoctor({super.key});

  @override
  State<ConsultDoctor> createState() => _ConsultDoctorState();
}

class _ConsultDoctorState extends State<ConsultDoctor> {
  List<Map<String, dynamic>> doctors = [
    {
      'name': "Dr Farrukh Akhtar",
      'address': "Ikram Hospital, Bhimber Rd, Gujrat",
      'ratings': '5.0',
      'contact': '+923424100004',
      'review': 1,
      'latitude': 32.59600473613835,
      'longitude': 74.07933061534453
    },
    {
      'name': "Dr Safdar Ali",
      'address': "Shadman Colony, Gujrat",
      'ratings': '5.0',
      'contact': "+923143939880",
      'review': 5,
      'latitude': 32.58868826742415,
      'longitude': 74.05840602388288
    },
    {
      'name': "Dr Fazilat Shahzadi",
      'address': "Jail Road Area, Gujrat",
      'ratings': '3.6',
      'contact': "+923366208800",
      'review': 32,
      'latitude': 32.5860096902833,
      'longitude': 74.0765869968755
    },
    {
      'name': "Psychologists Line",
      'address': "Rehman Shaheed Road, Court Area, Gujrat",
      'ratings': '4.5',
      'contact': "+923366208800",
      'review': 2,
      'latitude': 32.58535128586899,
      'longitude': 74.0791742460336
    },
  ];

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: customTextAlignCenter(
              text: "Consult Doctor",
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColor.viridianGreenColor),
                height: s.height * 0.25,
                width: s.width * 0.8,
                child: Center(
                  child: Lottie.asset('assets/animation/doctors.json',
                      width: s.width * 0.7,
                      height: s.height * 0.7,
                      reverse: true),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListTile(
                            isThreeLine: true,
                            leading: CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white70,
                              child: Image.asset(
                                'assets/image/doctorslogo.png',
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            title: Text(doctors[index]['name']),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctors[index]['address'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star_purple500_outlined,
                                      color: Colors.yellow.shade600,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(doctors[index]['ratings'].toString()),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("(${doctors[index]['review']})")
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.call,
                                      size: 20,
                                    ),
                                    Text(doctors[index]['contact'].toString()),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  double latitude = doctors[index]['latitude'];
                                  double longitude =
                                      doctors[index]['longitude'];

                                  // Use the coordinates to create the Google Maps URL
                                  String googleMapsUrl =
                                      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

                                  // Open the URL with the default browser or the Google Maps app if available
                                  launch(googleMapsUrl);
                                },
                                icon: Icon(
                                  Icons.map_rounded,
                                  color: AppColor.deepOrangeAccentColor,
                                )),
                          ),
                          Divider(
                            height: 2,
                            thickness: 3,
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
