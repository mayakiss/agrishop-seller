import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/loading.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/pos_repository.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import '../../custom/my_app_bar.dart';
import '../../helpers/shared_value_helper.dart';

class PosConfig extends StatefulWidget {
  const PosConfig({Key? key}) : super(key: key);

  @override
  State<PosConfig> createState() => _PosConfigState();
}

class _PosConfigState extends State<PosConfig> {
  TextEditingController _thermalPrinterSize = TextEditingController();


  update()async{
    if(_thermalPrinterSize.text.trim().isEmpty || !isNumeric(_thermalPrinterSize.text.trim())){
      return;
    }

    var response =await PosRepository().updateConfig(_thermalPrinterSize.text.trim());
    ToastComponent.showDialog(response.message);
  }

  getData()async{
OneContextLoading.show();
    var response =await PosRepository().posConfig();
    _thermalPrinterSize.text = response.message.toString();
    setState(() {

    });

    OneContextLoading.hide();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:
            app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          appBar: MyAppBar(
            context: context,
            title: "Pos Configuration",
          ).show(),
          body: buildBody(),
        ));
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          buildThermalPrinter(),
        ],
      ),
    );
  }

  itemSpacer({height = 10.0, width = 0.0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  buildBtn({
    text = '--',
    IconData? icon,
    Color? color,
    textColor = MyTheme.app_accent_color,
    fontWeight = FontWeight.normal,
    final VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 92.0,
        height: 34.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: color,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFCFD9E1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: fontWeight,
                  color: textColor,
                  height: 1.23,
                ),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                size: 16.0,
              )
          ],
        ),
      ),
    );
  }

  Widget customInpt({controller, text, hintText, keyBoardType}) {
    return SizedBox(
      height: 36,
      width: DeviceInfo(context).getWidth(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: TextField(
            keyboardType: keyBoardType,
            controller: controller,
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 12, color: MyTheme.textfield_grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyTheme.app_accent_color_extra_light, width: 1.0),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.zero,
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(4.0),
                    bottomLeft: Radius.circular(4.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyTheme.app_accent_color_extra_light, width: 1.0),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.zero,
                    bottomRight: Radius.zero,
                    topLeft: Radius.circular(6.0),
                    bottomLeft: Radius.circular(6.0)),
              ),
            ),
          )),
          Container(
            alignment: Alignment.center,
            height: 36,
            width: 60,
            decoration: BoxDecoration(
              color: MyTheme.app_accent_color_extra_light,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, color: MyTheme.grey_153),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildThermalPrinter() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: MyTheme.white,
        border: Border.all(
          width: 1.0,
          color: const Color(0xFFCFD9E1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 6.0),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Thermal Printer Size',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: MyTheme.app_accent_color,
                    fontWeight: FontWeight.w700,
                    height: 1.23,
                  ),
                ),
              ],
            ),
            itemSpacer(height: 12.0),
            customInpt(
              text: "mm",
              controller: _thermalPrinterSize,
              hintText: "Print width in mm",
              keyBoardType: TextInputType.number,
            ),
            itemSpacer(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                buildBtn(
                  onTap: (){
                    update();
                  },
                  text: "Save",
                  color: MyTheme.app_accent_color,
                  textColor: MyTheme.white,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
