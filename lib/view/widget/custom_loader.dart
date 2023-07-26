import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../constant/app_color/app_color.dart';


Widget customLoader() {
  return SpinKitDoubleBounce(
    color: AppColor.greenColor,
    size: 50,
  );
}
