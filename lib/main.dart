import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/size_config.dart';
import 'package:democratic_unity/views/FeedBack/feedback.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/views/splash.dart';
import 'package:democratic_unity/widgets/app_language.dart';
import 'package:democratic_unity/widgets/app_localization.dart';
import 'package:democratic_unity/widgets/env.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


SharedPreferences? prefs;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await configure();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(
      Phoenix(
        child: ViewModelBuilder<AppLanguage>.reactive(
          builder: (context, model, child) {
            return MaterialApp(
              locale: model.appLocale,
              debugShowCheckedModeBanner: false,
              navigatorKey: StackedService.navigatorKey,
              theme: ThemeData(
                  primaryColor: ColorUtils.blueColor,
                  textSelectionTheme: TextSelectionThemeData(
                    cursorColor: ColorUtils.blueColor,
                  )
              ),
              localeListResolutionCallback: (locales, supportedLocales) {

                print('device locales=$locales supported locales=$supportedLocales');

                for (Locale locale in locales!) {
                  // if device language is supported by the app,
                  // just return it to set it as current app language
                  if (supportedLocales.contains(locale)) {
                    return locale;
                  }
                }

                // if device language is not supported by the app,
                // the app will set it to english but return this to set to Bahasa instead
                return Locale('es');
              },
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', ''), // English, no country code
                Locale('es', ''), // Arabic, no country code
              ],
              home: MyApp(),
            );
          },
          viewModelBuilder: ()=>locator<AppLanguage>(),
          onModelReady: (model)async{
            print(model.appLocale);
            //AppLanguage appLanguage = AppLanguage();
            await model.fetchLocale();

          },
          disposeViewModel: false,
        ),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var email = prefs!.getString("email");
    var selectedDepart = prefs!.getString("department");
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return selectedDepart == null ? Splash() : MainView(index: 0);
          },
        );
      },
    );
  }
}
