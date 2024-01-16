// import 'dart:io';
//
// import 'package:active_ecommerce_seller_app/app_config.dart';
// import 'package:active_ecommerce_seller_app/custom/buttons.dart';
// import 'package:active_ecommerce_seller_app/custom/dialog_box.dart';
// import 'package:active_ecommerce_seller_app/custom/google_recaptcha.dart';
// import 'package:active_ecommerce_seller_app/custom/input_decorations.dart';
// import 'package:active_ecommerce_seller_app/custom/intl_phone_input.dart';
// import 'package:active_ecommerce_seller_app/custom/localization.dart';
// import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
// import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
// import 'package:active_ecommerce_seller_app/helpers/aiz_route.dart';
// import 'package:active_ecommerce_seller_app/helpers/auth_helper.dart';
// import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
// import 'package:active_ecommerce_seller_app/middlewares/mail_verification_route_middleware.dart';
// import 'package:active_ecommerce_seller_app/my_theme.dart';
// import 'package:active_ecommerce_seller_app/repositories/address_repository.dart';
// import 'package:active_ecommerce_seller_app/repositories/auth_repository.dart';
// import 'package:active_ecommerce_seller_app/screens/home.dart';
// import 'package:active_ecommerce_seller_app/screens/login.dart';
// import 'package:active_ecommerce_seller_app/screens/main.dart';
// import 'package:active_ecommerce_seller_app/screens/password_forget.dart';
// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
// import 'package:toast/toast.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class Registration extends StatefulWidget {
//   @override
//   _RegistrationState createState() => _RegistrationState();
// }
//
// class _RegistrationState extends State<Registration> {
//   String _login_by = "email"; //phone or email
//   String initialCountry = 'US';
//   PhoneNumber phoneCode = PhoneNumber(isoCode: 'US', dialCode: "+1");
//   String _phone = "";
//   late BuildContext loadingContext;
//   var countries_code = <String>[];
//
//   //controllers
//   TextEditingController nameController = TextEditingController();
//   TextEditingController shopNameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPassController = TextEditingController();
//   MyWidget? myWidget;
//   bool _isCaptchaShowing = false;
//   String googleRecaptchaKey = "";
//
//   onPressReg() async {
//     String name = nameController.text.trim();
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//     String confirmPassword = confirmPassController.text.trim();
//     String shopName = shopNameController.text.trim();
//     String address = addressController.text.trim();
//     loading();
//
//     var response = await AuthRepository().getRegResponse(
//         name: name,
//         email: email,
//         password: password,
//         confirmPassword: confirmPassword,
//         shopName: shopName,
//         address: address,
//         capchaKey: googleRecaptchaKey);
//     Navigator.pop(loadingContext);
//
//     if (response.result!) {
//       if (response.result != null && response.result!) {
//         AuthHelper().setUserData(response);
//         AIZRoute.pushAndRemoveAll(context, Main(),
//             middleware: MailVerificationRouteMiddleware());
//       } else {
//         AIZRoute.pushAndRemoveAll(context, Login());
//       }
//     } else {
//       if (context.mounted) {
//         DialogBox.warningShow(context, response.message);
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyTheme.app_accent_color,
//       body: buildBody(context),
//     );
//   }
//
//   Widget buildBody(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 36),
//       width: double.infinity,
//       child: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               LangText(context: context).getLocal()!.registration,
//               style: TextStyle(
//                   color: MyTheme.app_accent_border,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             spacer(height: 14),
//             Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(width: 1, color: MyTheme.medium_grey)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 24),
//                     child: Text(
//                       LangText(context: context).getLocal()!.personal_info_ucf,
//                       style: const TextStyle(
//                           color: MyTheme.app_accent_border,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   // Container(height: 1,color: MyTheme.medium_grey,),
//                   // spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context).getLocal()!.name_ucf,
//                       "Mr. Jhon",
//                       nameController),
//                   spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context).getLocal()!.email_ucf,
//                       "seller@example.com",
//                       emailController),
//                   spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context).getLocal()!.password_ucf,
//                       "● ● ● ● ●",
//                       passwordController,
//                       isPassword: true),
//                   spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context)
//                           .getLocal()!
//                           .confirm_your_password,
//                       "● ● ● ● ●",
//                       confirmPassController,
//                       isPassword: true),
//                   spacer(height: 14),
//                 ],
//               ),
//             ),
//             spacer(height: 20),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1, color: MyTheme.medium_grey),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 8.0, horizontal: 24),
//                     child: Text(
//                       LangText(context: context).getLocal()!.basic_info_ucf,
//                       style: TextStyle(
//                           color: MyTheme.app_accent_border,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   //Container(height: 1,color: MyTheme.medium_grey,),
//                   // spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context).getLocal()!.shop_name,
//                       "Shop",
//                       shopNameController),
//                   spacer(height: 14),
//                   inputFieldModel(
//                       LangText(context: context).getLocal()!.address_ucf,
//                       "Dhaka",
//                       addressController),
//                   spacer(height: 14),
//                 ],
//               ),
//             ),
//             if (google_recaptcha.$)
//               Container(
//                 padding: EdgeInsets.only(left: 0, right: 0, top: 14),
//                 height: _isCaptchaShowing ? 360 : 60,
//                 width: 300,
//                 child: Captcha(
//                   (keyValue) {
//                     googleRecaptchaKey = keyValue;
//                   },
//                   handleCaptcha: (data) {
//                     if (_isCaptchaShowing.toString() != data) {
//                       _isCaptchaShowing = data;
//                       setState(() {});
//                     }
//                   },
//                   isIOS: Platform.isIOS,
//                 ),
//               ),
//             spacer(height: 20),
//             Buttons(
//               width: MediaQuery.of(context).size.width,
//               height: 50,
//               color: Colors.white.withOpacity(0.8),
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(11.0),
//                 ),
//               ),
//               child: Text(
//                 LangText(context: context).getLocal()!.registration,
//                 style: const TextStyle(
//                     color: MyTheme.app_accent_color,
//                     fontSize: 17,
//                     fontWeight: FontWeight.w500),
//               ),
//               onPressed: () {
//                 onPressReg();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget inputFieldModel(
//       String title, String hint, TextEditingController controller,
//       {bool isPassword = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 color: MyTheme.app_accent_border,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12),
//           ),
//           const SizedBox(
//             height: 8,
//           ),
//           Container(
//             height: 36,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: const Color.fromRGBO(255, 255, 255, 0.5)),
//             child: TextField(
//               style: TextStyle(color: MyTheme.white),
//               controller: controller,
//               autofocus: false,
//               obscureText: isPassword,
//               decoration: InputDecorations.buildInputDecoration_1(
//                   borderColor: MyTheme.noColor,
//                   hint_text: hint,
//                   hintTextColor: MyTheme.dark_grey),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget spacer({height = 24}) {
//     return SizedBox(
//       height: double.parse(height.toString()),
//     );
//   }
//
//   loading() {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           loadingContext = context;
//           return AlertDialog(
//               content: Row(
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(
//                 width: 10,
//               ),
//               Text(AppLocalizations.of(context)!.please_wait_ucf),
//             ],
//           ));
//         });
//   }
// }
