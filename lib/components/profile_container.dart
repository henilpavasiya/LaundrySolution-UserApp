import '../package/config_packages.dart';

class ProfileDividerWidget extends StatelessWidget {
  ProfileDividerWidget({
    this.text,
    this.icon1,
    this.isRed,
    this.onTap,
    this.size,
    this.width,
    super.key,
  });

  bool? isRed = false;
  String? icon1;
  double? size;
  double? width;
  String? text;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    icon1 ?? "",
                    height: size,
                    color: AppColor.black,
                  ),
                  // Icon(
                  //   icon1,
                  //   color:
                  //       isRed ?? false ? AppColor.primaryRed : AppColor.gray800,
                  //   size: 25,
                  // ),
                   SizedBox(
                    width: width,
                  ),
                  Text(
                    text ?? "",
                    style: const TextStyle().normal18w400.textColor(
                      isRed ?? false
                          ? AppColor.primaryRed
                          : AppColor.gray800,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: isRed ?? false ? AppColor.primaryRed : AppColor.gray800,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}