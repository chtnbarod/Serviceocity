import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serviceocity/widget/custom_button.dart';
import 'package:serviceocity/widget/custom_input.dart';

import '../../core/di/api_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/assets.dart';
import '../../widget/common_image.dart';
import '../home/widget/show_animated_dialog.dart';
import 'logic.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  @override
  void initState() {
    Get.find<AccountLogic>().init();
    super.initState();
  }

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<AccountLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: getGalleryOrCamara,
                        child: Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: AppColors.blackColor().withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child:
                              file != null ?
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                                  color: Theme.of(context).selectedRowColor,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40.0),
                                  child: Image.file(File(file?.path ?? ""),
                                    height: 70.0,
                                    width: 70.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ) :
                              CommonImage(
                                assetPlaceholder: appUser,
                                imageUrl: "${ApiProvider.url}/${logic.userModel?.image}",
                                width: 70,
                                height: 70,
                                radius: 70,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                right: 5,
                                child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration:  BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.primaryColor(),
                                          AppColors.whiteColor(),
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.primaryColor(),
                                        style: BorderStyle.solid,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: const Icon(Icons.photo , size: 15 , color: Colors.white54,)
                                )
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
        
                  SizedBox(height: 40,),
        
        
                  const Text("Full Name"),
        
                  CustomInput(
                    textController: logic.nameController,
                    hintText: "Name",
                  ),
        
                  const SizedBox(height: 20,),
        
                  const Text("Email Id"),
        
                  CustomInput(
                    textController: logic.emailController,
                    hintText: "Email",
                  ),
        
                  // const SizedBox(height: 20,),
                  //
                  // const Text("Mobile Number"),
                  // CustomInput(
                  //   enabled: false,
                  //   textController: logic.phoneController,
                  //   hintText: "Mobile Number",
                  // ),
        
                  const SizedBox(height: 50,),
        
                  CustomButton(
                    text: "Update",
                    onTap: (){
                      logic.updateUser(file);
                    },
                    isLoading: logic.updating,
                  )
        
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> getGalleryOrCamara() async {
    return showAnimatedDialog(context , Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [

            Positioned(
              left: 0,
              top: 5,
              child: Row(
                children: [
                  const SizedBox(width: 10,),
                  Text("Select Media Option".tr,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17
                  ),),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: ListBody(
                  children: [
                    ListTile(
                      onTap: (){
                        pickGalleryPic().then((value) => {
                          Navigator.pop(context)
                        });
                      },
                      title: Text("Gallery".tr),
                      leading: Icon(Icons.perm_media,color: AppColors.primary,),
                    ),

                    SizedBox(height: 5,),
                    ListTile(
                      onTap: (){
                        pickCameraPic().then((value) => {
                          Navigator.pop(context),
                        });
                      },
                      title: Text("Camera".tr),
                      leading: Icon(Icons.camera,color: AppColors.primary,),
                    ),
                  ],
                ),
              ),),

          ],
        ),
      ),
    ) , dismissible: true);
  }

  Future<void> pickGalleryPic() async{
    try{
      await FilePicker.platform.pickFiles(withReadStream: true , type: FileType.image).then((value) =>{
        if(value != null){
          file = File(value.files.single.path!),
          if(mounted){
            setState(() {})
          }
        },
      });
    }catch(e){
      //
    }
  }

  Future<void> pickCameraPic() async{
    try{
      final ImagePicker picker = ImagePicker();
      final mImage = await picker.pickImage(source: ImageSource.camera);
      if(mImage == null) return;
      await getFile(File(mImage.path)).then((value) => {
        file = value,
        if(mounted){
          setState(() {}),
        },
      });
    } on PlatformException catch (e){
      //
    }
  }

}

Future<File> getFile(File file) async{
  try{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square
      ],
      maxHeight: 250,
      maxWidth: 250,
    );

    if(croppedFile != null){
      return File(croppedFile.path);
    }else{
      return file;
    }
  }catch (e){
    return file;
  }
}


// Future<File> getFile(File file) async{
//   return file;
// }
