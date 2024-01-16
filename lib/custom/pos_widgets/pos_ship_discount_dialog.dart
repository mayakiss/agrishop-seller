import 'package:active_ecommerce_seller_app/custom/aiz_typedef.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

import '../../helpers/main_helper.dart';
import '../../my_theme.dart';

class PosShipDiscountDialog extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final futureVoid? callback;

  const PosShipDiscountDialog({
    Key? key,
    this.controller,
    this.title,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title!,
        style: const TextStyle(fontSize: 16, color: MyTheme.app_accent_color),
      ),
      content: SizedBox(
        height: 36,
        width: 200,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: TextField(
                keyboardType: TextInputType.number,
                controller: controller,
                // onChanged: (value) {},
                onEditingComplete: () {
                  callback!();
                  Navigator.pop(OneContext().context!);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyTheme.app_accent_color_extra_light,
                        width: 1.0),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: MyTheme.app_accent_color_extra_light,
                        width: 1.0),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.zero,
                        bottomRight: Radius.zero,
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0)),
                  ),
                ),
              ),
            ),
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
                getLocal(context).flat_ucf,
                style: const TextStyle(fontSize: 12, color: MyTheme.grey_153),
              ),
            ),
          ],
        ),
      ),
    );
  }

// customInpt({controller, text, keyBoardType, callback}) async {
//   return SizedBox(
//     height: 36,
//     width: 200,
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Flexible(
//           child: TextField(
//             keyboardType: keyBoardType,
//             controller: controller,
//             onChanged: (value) {},
//             onEditingComplete: () async => await callback,
//             decoration: InputDecoration(
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: MyTheme.app_accent_color_extra_light, width: 1.0),
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.zero,
//                     bottomRight: Radius.zero,
//                     topLeft: Radius.circular(4.0),
//                     bottomLeft: Radius.circular(4.0)),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                     color: MyTheme.app_accent_color_extra_light, width: 1.0),
//                 borderRadius: const BorderRadius.only(
//                     topRight: Radius.zero,
//                     bottomRight: Radius.zero,
//                     topLeft: Radius.circular(6.0),
//                     bottomLeft: Radius.circular(6.0)),
//               ),
//             ),
//           ),
//         ),
//         Container(
//           alignment: Alignment.center,
//           height: 36,
//           width: 60,
//           decoration: BoxDecoration(
//             color: MyTheme.app_accent_color_extra_light,
//             borderRadius: const BorderRadius.only(
//               bottomRight: Radius.circular(6),
//               topRight: Radius.circular(6),
//             ),
//           ),
//           child: Text(
//             text,
//             style: const TextStyle(fontSize: 12, color: MyTheme.grey_153),
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
