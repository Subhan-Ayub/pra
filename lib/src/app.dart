import 'package:flutter/material.dart';
import 'package:flutter_task/src/utils/routes/appPages.dart';
import 'package:get/route_manager.dart';


class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Popins',
      ),
      // home: const Text('data'),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // onUnknownRoute: (RouteSettings rs) => MaterialPageRoute(
      //   builder: (context) {
      //     return ErrorView(
      //       // icon: UIDataVector.vectorSadSmiley,
      //       message: 'Coming Soon!',
      //     );
      //   },
      // ),
    );
  }
}
