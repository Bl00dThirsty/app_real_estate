
import 'package:Resmartha/pages/home.dart';
import 'package:Resmartha/pages/payment.dart';
import 'package:Resmartha/pages/pub_page.dart';
import 'package:Resmartha/pages/root.dart';
import 'package:Resmartha/pages/search_page.dart';
import 'package:Resmartha/pages/success.dart';
import 'package:Resmartha/services/authentication_services.dart';
import 'package:Resmartha/services/database_services.dart';
import 'package:Resmartha/services/wrapper.dart';
import 'package:Resmartha/utils/theme/theme.dart';
import 'package:Resmartha/views/detail/detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'models/villa_model.dart';
import 'pages/profile.dart';
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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resmartha',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      //initialBinding: GeneralBindings(),
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/profile': (context) => const Profile(),
        '/detail': (context) => const AppartDetail(),
        '/pub': (context) => const PubPage(),
        '/search':(context) => const SearchPage(),
        '/payment':(context) => Payment(),
        '/success':(context) => Success(),
        '/root': (context) => const RootApp(),
        '/home' : (context) => const HomePage(),
      },
    );
  }
}