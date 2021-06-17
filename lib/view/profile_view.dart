import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_button.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_card.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';

class ProfileView extends StatelessWidget {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String name,mobile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context,'profile'), style: TextStyle(color: kPrimaryColor)),
          centerTitle: true,
          elevation: 1,
          actions: [
            GetBuilder<ProfileViewModel>(
              init: Get.find(),
              builder:(controller)=> IconButton(
                icon: Icon(
                  Icons.save,
                  color: kPrimaryColor,
                ),
                onPressed: ()async {
                  await controller.uploadImage();
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: GetBuilder<ProfileViewModel>(
            init: ProfileViewModel(),
            builder: (controller) => controller.loading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.defaultSize * 5,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: SizeConfig.defaultSize * 15,
                              width: SizeConfig.defaultSize * 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  //color: Colors.black,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 5,
                                  ),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: controller.image != null
                                          ? FileImage(controller.image)
                                          : (controller.user.img != null&&controller.user.img!=''
                                              ? NetworkImage(
                                                  controller.user.img)
                                              : AssetImage(
                                                  'assets/images/no-img.png')))),
                            ),
                            Positioned(
                              bottom: SizeConfig.defaultSize * 2,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 18,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: getTranslated(context,'addImage'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Divider(
                                              color: kPrimaryColor,
                                              height: 10,
                                            ),
                                            FlatButton(
                                              child: Text(getTranslated(context,'fromCamera')),
                                              onPressed: () {
                                                Get.back();
                                                controller.getImage(
                                                    source: ImageSource.camera);
                                              },
                                            ),
                                            Divider(
                                              color: kPrimaryColor,
                                              height: 10,
                                            ),
                                            FlatButton(
                                              child: Text(getTranslated(context,'fromGallery')),
                                              onPressed: () {
                                                Get.back();
                                                controller.getImage(
                                                    source:
                                                        ImageSource.gallery);
                                              },
                                            ),
                                            Divider(
                                              color: kPrimaryColor,
                                              height: 10,
                                            ),
                                            //FlatButton(child: Text('Cancel'),onPressed: (){},),
                                          ],
                                        ), //Divider(color: kPrimaryColor,height: 20,),
                                        actions: [
                                          Column(
                                            children: [
                                              FlatButton(
                                                child: Text(getTranslated(context,'cancel')),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          )
                                        ]);
                                  },
                                  child: CircleAvatar(
                                    foregroundColor: Colors.grey,
                                    backgroundColor: Colors.white,
                                    radius: 15,
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize,
                      ),
                      /* CustomText(
                        text: controller.user.name,
                        size: SizeConfig.defaultSize * 3,
                        fontWeight: FontWeight.bold,
                      ), */
                      CustomText(
                        text: controller.user.email,
                        size: SizeConfig.defaultSize * 2,
                      ),
                      SizedBox(
                        height: SizeConfig.defaultSize * 2,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: FlatButton(
                          child: CustomText(
                            text: getTranslated(context,'edit'),
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Get.bottomSheet(
                              Container(
                                padding: EdgeInsets.all(SizeConfig.defaultSize),
                                child: Form(  
                                  key: globalKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        UpdateUserTextField(
                                          label: getTranslated(context,'fullName'),
                                          initialValue: controller.user.name,
                                          onSave: (value){name=value;},
                                        ),
                                        UpdateUserTextField(
                                          initialValue: controller.user.mobile,
                                          label: getTranslated(context,'mobile'),
                                          inputType: TextInputType.phone,
                                          onSave: (value){mobile=value;},
                                        ),
                                        SizedBox(height: SizeConfig.defaultSize*2,),
                                        CustomButton(text: getTranslated(context,'save'),press: ()async{
                                          if(globalKey.currentState.validate()){
                                            globalKey.currentState.save();
                                            await controller.updateUserData(name,mobile);
                                            Get.back();

                                          }
                                        },)
                                      ],
                                    ),
                                  ),
                                ),
                                height: SizeConfig.defaultSize * 26,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                    color: Colors.white),
                              ),
                              isDismissible: true,
                              elevation: 0,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            );
                            // Get.bottomSheet(Container());
                          },
                        ),
                      ),
                      CustomCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text(getTranslated(context,'fullName')),
                              subtitle: CustomText(
                                text: controller.user.name,
                                size: SizeConfig.defaultSize * 2,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.call),
                              title: Text(getTranslated(context,'mobile')),
                              subtitle: CustomText(
                                text: controller.user.mobile,
                                size: SizeConfig.defaultSize * 2,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                      /* CustomButton(
                        text: 'Upload',
                        press: () async {
                          await controller.uploadImage();
                        },
                      ) */
                    ],
                  ),
          ),
        ));
  }
}

class UpdateUserTextField extends StatelessWidget {
  String initialValue;
  String label;
  String hint;
  TextInputType inputType;
  Function onFieldSubmitting;
  Function onSave;
  UnderlineInputBorder outlineInputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.circular(0),
      borderSide: BorderSide(color: Colors.blue, width: 1));

  UpdateUserTextField(
      {this.initialValue,
      this.inputType,
      this.label,
      this.hint,
      this.onFieldSubmitting,
      this.onSave});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultSize,
          vertical: SizeConfig.defaultSize * 1.5),
      child: TextFormField(
        initialValue: initialValue,
        style: TextStyle(
            color: Colors.black, fontSize: SizeConfig.defaultSize * 2),
        keyboardType: inputType,
        decoration: InputDecoration(
            hintText: hint,
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            focusedBorder: outlineInputBorder,
            labelText: label),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: onFieldSubmitting,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please provide a value,';
          }
          return null;
        },
        onSaved: onSave,
      ),
    );
  }
}
