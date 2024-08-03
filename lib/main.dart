import 'package:app_real_estate/features/authentication/screens/signup/signup.dart';
import 'package:app_real_estate/models/villa_model.dart';
import 'package:app_real_estate/pages/pub_page.dart';
import 'package:app_real_estate/pages/root.dart';
import 'package:app_real_estate/pages/search_page.dart';
import 'package:app_real_estate/services/authentication_services.dart';
import 'package:app_real_estate/services/database_services.dart';
import 'package:app_real_estate/services/wrapper.dart';
import 'package:app_real_estate/utils/constants/colors.dart';
import 'package:app_real_estate/utils/theme/theme.dart';
import 'package:app_real_estate/views/detail/detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'pages/profile.dart';
import 'theme/color.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


// ....then((FirebaseApp value) => Get.put(AuthenticationRepository())

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(providers: [
      StreamProvider.value(
        initialData: null,
        value: AuthService().user,
      ),
      StreamProvider<List<Appart>>.value(
        initialData: [],
        value: DatabaseService().apparts,
      )
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real Estate App',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/profile': (context) => Profile(),
        '/detail': (context) => AppartDetail(),
        '/pub': (context) => PubPage(),
        '/search':(context) => SearchPage(),
        '/root': (context) => RootApp(),
      },
    );
  }
}