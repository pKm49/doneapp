import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:doneapp/shared_module/constants/style_params.constants.shared.dart';
import 'package:doneapp/shared_module/constants/widget_styles.constants.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/toaster_snackbar_shower.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_generator.service.shared.dart';
import 'package:doneapp/shared_module/services/utility-services/widget_properties_generator.service.shared.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
class PhotoSelector extends StatelessWidget {

  final Function(File? photo) photoSelected;      // <------------|

  const PhotoSelector({super.key, required this.photoSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:   RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(APPSTYLE_BorderRadiusSmall))),
      contentPadding: const EdgeInsets.symmetric(vertical: APPSTYLE_SpaceMedium, horizontal: APPSTYLE_SpaceMedium),
      content: SizedBox(
        height: Localizations.localeOf(context)
            .languageCode
            .toString() ==
            'ar'?125:100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                handleMediaClick(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(APPSTYLE_SpaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.photo, color: APPSTYLE_PrimaryColor),
                    addHorizontalSpace(APPSTYLE_SpaceMedium),
                    Expanded(
                      child: Text('choose_from_gallery'.tr),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                handleCameraClick(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(APPSTYLE_SpaceSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.camera_alt,
                        color: APPSTYLE_PrimaryColor),
                    addHorizontalSpace(APPSTYLE_SpaceMedium),
                    Expanded(
                      child: Text('open_camera'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  openFilePicker() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await cropImage(pickedFile.path!);
    } else {
      return;
    }
  }
   
  Future<void> getPictureFromCamera() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      await cropImage(pickedFile.path!);
    } else {
      return;
    }
  }

  cropImage(filePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: APPSTYLE_PrimaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);

    if (croppedFile != null) {
       photoSelected(File(croppedFile!.path));
    }else{
      photoSelected(null);
    }
  }

  Future<void> handleMediaClick(context) async {
    print("handleMediaClick");
    if (Platform.isIOS) {
      if (await Permission.photos.isGranted) {
        openFilePicker();
      } else {
        if (await Permission.photos.isPermanentlyDenied) {
          showSnackbar(context, "media_permission_message".tr, "error");
        }else{
          showPhotosPermissionDialogue( );
        }
      }
    } else if (Platform.isAndroid) {
      final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
      final int sdkInt = android.version.sdkInt;
      print("Device is Android");
      print(sdkInt);
      if(sdkInt>32){
        print("sdkInt>32");

        if (await Permission.photos.isGranted) {
          print("Permission is granted");
          openFilePicker();
        } else {
          print("Permission not granted");
          if (await Permission.photos.isPermanentlyDenied) {
            print("Permission isPermanentlyDenied");
            showSnackbar(context, "media_permission_message".tr, "error");
          }else{
            print("Permission is not PermanentlyDenied");
            showPhotosPermissionDialogue( );
          }
        }
      }else{
        print("sdkInt<32");
        if (await Permission.storage.isGranted) {
          openFilePicker();
        } else {
          if (await Permission.storage.isPermanentlyDenied) {
            showSnackbar(context, "media_permission_message".tr, "error");
          }else{
            showPhotosPermissionDialogue( );
          }
        }
      }
    }

  }

  Future<void> handleCameraClick(BuildContext context) async {
    if (await Permission.camera.isGranted) {
      getPictureFromCamera();
    } else {
      if (await Permission.camera.isPermanentlyDenied) {
        showSnackbar(
            context, "camera_permission_message".tr, "error");
      }else{
        showCameraPermissionDialogue();
      }

    }
  }

  void showPhotosPermissionDialogue() async {

    BuildContext context = Get.context!;

    final dialogTitleWidget = Text('photo_access_permission_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text( 'photo_access_permission_info'.tr,style: getBodyMediumStyle(context));

    final updateButtonTextWidget = Text('continue'.tr,style: TextStyle(color: APPSTYLE_BackgroundWhite));

    updateAction() async {
      Navigator.pop(context);
      if (Platform.isIOS) {
        final PermissionStatus try1 = await Permission.photos.request();
        if (try1 == PermissionStatus.granted) {
          openFilePicker();
        }else{
          showSnackbar(
              context, "media_permission_message".tr, "error");
        }
      }else{
        final AndroidDeviceInfo android = await DeviceInfoPlugin().androidInfo;
        final int sdkInt = android.version.sdkInt;
        if(sdkInt>32){
          final PermissionStatus try1 = await Permission.photos.request();
          if (try1 == PermissionStatus.granted) {
            openFilePicker();
          }else{
            showSnackbar(
                context, "media_permission_message".tr, "error");
          }
        }else{
          final PermissionStatus try1 = await Permission.storage.request();
          if (try1 == PermissionStatus.granted) {
            openFilePicker();
          }else{
            showSnackbar(
                context, "media_permission_message".tr, "error");
          }
        }
      }
    }

    List<Widget> actions = [

      ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child: AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );

  }

  void showCameraPermissionDialogue() async {
    BuildContext context = Get.context!;

    final dialogTitleWidget = Text('camera_access_permission_title'.tr,style: getHeadlineMediumStyle(context).copyWith(color: APPSTYLE_Grey80,fontWeight: APPSTYLE_FontWeightBold));
    final dialogTextWidget = Text( 'camera_access_permission_info'.tr,style: getBodyMediumStyle(context),);

    final updateButtonTextWidget = Text('continue'.tr,style: TextStyle(color: APPSTYLE_BackgroundWhite));

    updateAction() async {
      Navigator.pop(context);
      final PermissionStatus try1 = await Permission.camera.request();
      if (try1 == PermissionStatus.granted) {
        getPictureFromCamera();
      }else{
        showSnackbar(
            context, "camera_permission_message".tr, "error");
      }

    }

    List<Widget> actions = [

      ElevatedButton(
          onPressed:updateAction,
          style: getElevatedButtonStyle(context).copyWith(padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  horizontal: APPSTYLE_SpaceLarge,
                  vertical: APPSTYLE_SpaceSmall))),
          child:  updateButtonTextWidget)
    ];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
            child:AlertDialog(
              title: dialogTitleWidget,
              content: dialogTextWidget,
              actions: actions,
            ),
            onWillPop: () => Future.value(false));
      },
    );

  }

}

