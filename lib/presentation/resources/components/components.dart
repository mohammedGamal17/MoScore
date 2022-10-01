import 'package:flutter/material.dart';
import 'package:moscore/presentation/resources/colors/color_manager.dart';



void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget;
    }));

void navigateToAndReplace(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return widget;
        },
      ),
      (route) => false,
    );

Widget textFormField({
  required TextEditingController controller,
  required Function validate,
  required String labelText,
  required IconData prefix,
  required TextInputType textInputType,
  double borderRadius = 10.0,
  bool autoFocus = false,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixOnTap,
  Function? onTap,
  Function? onChange,
  Function? onSubmit,
  TextDirection? textDirection,
  int maxLen = 75,
}) {
  return TextFormField(
    keyboardType: textInputType,
    style:  TextStyle(color: ColorManager.white),
    controller: controller,
    autofocus: autoFocus,
    obscureText: isPassword,
    decoration: InputDecoration(
      focusedBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.white, width: 3.0),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      labelText: labelText,
      filled: true,
      labelStyle:  TextStyle(color: ColorManager.white),
      prefixIcon: Icon(prefix, color: ColorManager.white),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: () {
                suffixOnTap!();
              },
              icon: Icon(suffix),
            )
          : null,
      suffixIconColor: ColorManager.white,
    ),
    textDirection: textDirection,
    validator: (value) {
      return validate(value);
    },
    onTap: () {
      // ignore: void_checks
      onTap!();
    },
    onChanged: (String value) {
      onChange!(value);
    },
    onFieldSubmitted: (value) {
      onSubmit!(value);
    },
  );
}

// Widget separator() {
//   return Padding(
//     padding: const EdgeInsets.all(10.0),
//     child: Container(
//       height: 2.0,
//       //color: HexColor('DEE2E6'),
//     ),
//   );
// }

Widget circularProgressIndicator() {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: ColorManager.backGround,
    color: ColorManager.primary
  ));
}

Widget decorationButton(
  context, {
  Widget? pageRoute,
  Color? color,
  required String text,
}) {
  return InkWell(
    onTap: () {
      navigateTo(context, pageRoute);
    },
    child: Center(
      child: Container(
        height: 40.0,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: ColorManager.backGround,
          gradient: LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              ColorManager.lightPrimary,
              ColorManager.primary
            ],
          ),
        ),
        child: Text(text, style: Theme.of(context).textTheme.bodyText1),
      ),
    ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snack(
  context, {
  required String content,
  Color? bgColor = Colors.green,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      content,
      style: Theme.of(context).textTheme.bodyText1,
      textAlign: TextAlign.center,
    ),
    duration: const Duration(milliseconds: 4000),
    padding: const EdgeInsets.all(8),
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    behavior: SnackBarBehavior.fixed,
  ));
}

// Widget courserSlider() {
//   return CarouselSlider(
//       items: model.data?.banners?.map((i) {
//         return Builder(
//           builder: (BuildContext context) {
//             return Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: HexColor('0096C7'),
//                 image: DecorationImage(
//                   image: NetworkImage('${i.image}'),
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             );
//           },
//         );
//       }).toList(),
//       options: CarouselOptions(
//         height: 250.0,
//         aspectRatio: 16 / 9,
//         viewportFraction: 0.8,
//         initialPage: 0,
//         enableInfiniteScroll: true,
//         reverse: false,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 3),
//         autoPlayAnimationDuration: const Duration(milliseconds: 800),
//         autoPlayCurve: Curves.fastOutSlowIn,
//         enlargeCenterPage: true,
//         scrollDirection: Axis.horizontal,
//       ));
// }
