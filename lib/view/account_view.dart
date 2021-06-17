import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safwat_pharmacy/core/view_model/account_view_model.dart';
import 'package:safwat_pharmacy/core/view_model/profile_view_model.dart';
import 'package:safwat_pharmacy/costants.dart';
import 'package:safwat_pharmacy/helper/app_locale.dart';
import 'package:safwat_pharmacy/helper/local_storage_data.dart';
import 'package:safwat_pharmacy/size_config.dart';
import 'package:safwat_pharmacy/view/addresses_view.dart';
import 'package:safwat_pharmacy/view/custom_widgets/custom_text.dart';
import 'package:safwat_pharmacy/view/favorites_view.dart';
import 'package:safwat_pharmacy/view/profile_view.dart';
import 'package:safwat_pharmacy/view/returns_view.dart';
import 'order_view.dart';

class AccountView extends StatelessWidget {
  LocalStoreageData storageController=Get.put(LocalStoreageData());
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileViewModel());
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                //     horizontal: SizeConfig.defaultSize,
                vertical: SizeConfig.defaultSize * 2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize),
                child: GetBuilder<ProfileViewModel>(
                  init: ProfileViewModel(),
                  builder: (controller) => Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        child: controller.user != null
                            ? controller.user.img == null||controller.user.img==''
                                ? Icon(Icons.person,
                                    size: 50, color: Colors.white)
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: Colors.grey, width: 2),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                controller.user.img))),
                                  )
                            : Icon(Icons.person, size: 50, color: Colors.white),
                        radius: SizeConfig.defaultSize * 4,
                      ),
                      SizedBox(
                        width: SizeConfig.defaultSize * 2,
                      ),
                      CustomText(
                        text:
                            controller.user == null ? "" : controller.user.name,
                        size: SizeConfig.defaultSize * 2.5,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 2,
              ),
              Card(
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AccountUserCard(
                      icon: Icons.article_outlined,
                      title: getTranslated(context,'orders'),
                      press: () {
                        Get.to(OrderView());
                      },
                    ),
                    AccountUserCard(
                      icon: Icons.undo,
                      title: getTranslated(context,'returns'),
                      press: () {
                        Get.to(ReturnsView());
                      },
                    ),
                    AccountUserCard(
                      press: () {
                        Get.to(FavoritesView());
                      },
                      icon: Icons.favorite_border,
                      title: getTranslated(context,'favorites'),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.defaultSize,
                        horizontal: SizeConfig.defaultSize),
                    child: CustomText(
                      text: getTranslated(context,'myAccount').toUpperCase(),
                      size: SizeConfig.defaultSize * 1.8,
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        _customListile(
                            press: () {
                              Get.to(ProfileView());
                            },
                            icon: Icons.account_box_outlined,
                            title: getTranslated(context,'profile'),
                            trailing: storageController.language != 'ar'
                                ? Icon(Icons.arrow_forward_ios_outlined)
                                : Icon(Icons.arrow_back_ios_outlined),),
                        Divider(),
                        _customListile(
                            icon: Icons.place,
                            title: getTranslated(context,'address'),
                            trailing: storageController.language != 'ar'
                                ? Icon(Icons.arrow_forward_ios_outlined)
                                : Icon(Icons.arrow_back_ios_outlined),
                            press: () {
                              Get.to(AddressessView());
                            }),
                        Divider(),
                        _customListile(
                            icon: Icons.language_outlined,
                            title: getTranslated(context, 'language'),
                            trailing: Container(
                              width: SizeConfig.defaultSize * 10,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: getTranslated(context, 'lng'),
                                  ),
                                  storageController.language != 'ar'
                                ? Icon(Icons.arrow_forward_ios_outlined)
                                : Icon(Icons.arrow_back_ios_outlined),
                                ],
                              ),
                            ),
                            press: () async {
                              //    MyApp.setLocale(context,Locale('ar'));
                              
                              storageController.language!='ar'?
                              await storageController.setLanguage('ar'):await storageController.setLanguage('en');
                             
                              
                               Phoenix.rebirth(context);
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize,
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.defaultSize),
                    child: Text(getTranslated(context,'reachToUs').toUpperCase()),
                  ),
                  Card(
                    child: _customListile(
                        icon: Icons.call,
                        title: getTranslated(context,'contactUs'),
                        trailing: storageController.language != 'ar'
                                ? Icon(Icons.arrow_forward_ios_outlined)
                                : Icon(Icons.arrow_back_ios_outlined),
                        press: ()  {
                         
                        }),
                  ),
                  SizedBox(
                    height: SizeConfig.defaultSize * 2,
                  ),
                  GetBuilder<AccountViewModel>(
                    init: AccountViewModel(),
                    builder: (controller) => ListTile(
                      onTap: () {
                        controller.signOut();
                      },
                      leading: Icon(Icons.logout),
                      title: Text(getTranslated(context,'logOut').toUpperCase()),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  ListTile _customListile(
      {String title, IconData icon, Function press, Widget trailing}) {
    return ListTile(
      leading: Icon(
        icon,
        size: SizeConfig.defaultSize * 3.2,
        color: Colors.black54,
      ),
      title: Text(title),
      trailing: trailing,

      //Icon(Icons.arrow_forward_ios_outlined),
      onTap: press,
    );
  }
}

class AccountUserCard extends StatelessWidget {
  IconData icon;
  String title;
  Function press;

  AccountUserCard({this.icon, this.title, this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              foregroundColor: Colors.white,
              backgroundColor: kPrimaryColor,
              child: Icon(icon),
            ),
            CustomText(
              text: title,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
