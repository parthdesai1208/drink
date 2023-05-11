import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DeviceDetectorWidget extends StatelessWidget {
  final Widget Function() webSiteView;
  final Widget Function() tabletView;
  final Widget Function() phoneView;

  DeviceDetectorWidget({
    required this.webSiteView,
    required this.tabletView,
    required this.phoneView,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
        if (sizingInformation.screenSize.width <= 1050 &&
            sizingInformation.screenSize.width >= 800) {
          return tabletView.call();
        } else {
          return webSiteView.call();
        }
      }

      if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        return tabletView.call();
      }

      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        return phoneView.call();
      }

      return webSiteView.call();
    });
  }



// @override
// Widget build(BuildContext context) {
//   if (kIsWeb) {
//     return webSiteView.call();
//   } else {
//     final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
//     if (data.size.shortestSide < 550) {
//       return phoneView.call();
//     } else {
//       return tabletView.call();
//     }
//   }
// }
}