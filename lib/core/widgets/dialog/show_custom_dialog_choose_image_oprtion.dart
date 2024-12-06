import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:flutter/material.dart';

void showCustomDialogChooseImage({
  required BuildContext context,
  required VoidCallback onPressedPickImageBYGallery,
  required VoidCallback onPressedPickImageBYCamera,
}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => true
        ? AlertDialog(
            titlePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(RadiusValuesManager.br12))),
            backgroundColor: ColorManager.kGrey2Color,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    onPressedPickImageBYGallery();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: PaddingManager.pw8,
                        vertical: PaddingManager.ph8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ConstValue.kPhotoLibrary,
                            style: TextStyle(
                                fontSize: FontsSize.f12,
                                color: ColorManager.kWhiteColor,
                                fontFamily: FontsName.geDinerOneFont),
                          ),
                        ),
                        const Icon(
                          Icons.photo_library,
                          color: ColorManager.kWhiteColor,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: ColorManager.kWhiteColor.withOpacity(.3),
                ),
                InkWell(
                  onTap: () {
                    onPressedPickImageBYCamera();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: PaddingManager.pw8,
                        vertical: PaddingManager.ph8),  child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            ConstValue.kTakePhoto,
                            style: TextStyle(
                                fontSize: FontsSize.f12,
                                color: ColorManager.kWhiteColor,
                                fontFamily: FontsName.geDinerOneFont),
                          ),
                        ),
                        const Icon(
                          Icons.camera_alt,
                          color: ColorManager.kWhiteColor,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                    iconSize: 50,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.kPrimaryColor),
                    onPressed: onPressedPickImageBYGallery,
                    icon: const Icon(Icons.image)),
                HorizontalSpace(WidthManager.w30),
                IconButton.filled(
                    iconSize: 50,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.kPrimaryColor),
                    onPressed: onPressedPickImageBYCamera,
                    icon: const Icon(Icons.camera_alt)),
              ],
            ),
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton.filled(
                  iconSize: 10,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    size: 20,
                    Icons.close,
                    color: ColorManager.kWhiteColor,
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                Text(
                  ConstValue.kChooseFrom,
                  style: TextStyle(
                      fontFamily: FontsName.geDinerOneFont,
                      fontWeight: FontWeight.w900,
                      fontSize: FontsSize.f15),
                )
              ],
            ),
          ),
  );
}
