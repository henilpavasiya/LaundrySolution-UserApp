import 'package:ft_washing_app/components/profile_container.dart';
import 'package:ft_washing_app/module/bottom/profile/profile_controller.dart';
import 'package:ft_washing_app/package/config_packages.dart';
import 'package:ft_washing_app/utils/const_string.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/images.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.put<ProfileController>(ProfileController());

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      PermissionStatus newStatus = await Permission.location.request();
      if (newStatus.isDenied) {
        // User denied the permission, handle accordingly
      }
    }
  }

  getCurrentLocation() async {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        profileController.currentPosition = position;
        print("Current Distance:-$profileController.currentPosition");
        print("Current Latitude:-${profileController.currentPosition!.latitude}");
        print("Current Longitude:-${profileController.currentPosition!.longitude}");
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestLocationPermission().then((_) {
      getCurrentLocation();
    });
  }
  void openLogOutDialog() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(ConstString.logOutMessage),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Get.back();
                },
                child: const Text(ConstString.no),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () async {
                  profileController. logOut();

                  Get.offAllNamed(AppRouter.login);
                },
                child: const Text(ConstString.yes),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        appBar: AppBar(),
        isShowBackButton: false,
        title: ConstString.userProfile,
      ),
      backgroundColor: AppColor.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ///profile header
          // Obx(
          // ()=>Center(
          //     child: Column(
          //       children: [
          //         const ClipOval(
          //           child: Icon(
          //           Icons.account_circle,
          //             size: 100,
          //           )
          //         ),
          //         const SizedBox(
          //           height: 7,
          //         ),
          //         Text(
          //            "${profileController.userData.value?.firstName??""} ${profileController.userData.value?.lastName??""}",
          //           style: const TextStyle().normal20w600,
          //         ),
          //         const SizedBox(
          //           height: 5,
          //         ),
          //         Text(
          //           profileController.userData.value?.email??"",
          //           style: const TextStyle().normal14w400,
          //         ),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         Text(
          //           profileController.userData.value?.mobileNumber??"",
          //           style: const TextStyle().normal14w400,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(

              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: AppColor.primary.withOpacity(0.05),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ProfileDividerWidget(
                    size: 38,
                    width: 12,
                    onTap: () {
                      Get.toNamed(AppRouter.myProfileScreen);
                    },
                    icon1: myProfile,
                    text: ConstString.myProfile,
                  ),
                  ProfileDividerWidget(
                    size: 30,
                    width: 20,
                    onTap: () {
                      Get.toNamed(AppRouter.laundryLocation);
                    },
                    icon1: nearby,
                    text: ConstString.nearbyLaundryLocation,
                  ),
                  ProfileDividerWidget(
                    size: 30,
                    width: 20,
                    onTap: () {
                      Get.toNamed(AppRouter.laundryOneScreen);
                    },
                    icon1: editAccount,
                    text: ConstString.laundryLocation,
                  ),
                  ProfileDividerWidget(
                    size: 30,
                    width: 20,
                    onTap: () {
                      Get.toNamed(AppRouter.allAddress);
                    },
                    icon1: editAddress,
                    text: ConstString.addAddress,
                  ),
                  ProfileDividerWidget(
                    size: 28,
                    width: 20,
                    onTap: () {
                      Get.toNamed(AppRouter.myPlan);
                    },
                    icon1: yourPlanIcon,
                    text: ConstString.myPlan,
                  ),
                  ProfileDividerWidget(
                    size: 35,
                    width: 13,
                    onTap: () {
                      Get.toNamed(AppRouter.changePassword);
                    },
                    icon1: changePassIcon,
                    text: ConstString.changePassword,
                  ),
                  ProfileDividerWidget(
                    size: 33,
                    width: 14,
                    onTap: () {
                      openLogOutDialog();
                    },
                    isRed: true,
                    icon1: logOutIcon,
                    text: ConstString.logOut,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
