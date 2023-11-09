import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'package:flutter/material.dart';
import 'package:infinicalc/controllers/font_size_provider.dart';
import 'package:infinicalc/ui/home_screen.dart';
import 'package:infinicalc/widgets/conversions/area.dart';
import 'package:infinicalc/widgets/conversions/distance.dart';
import 'package:infinicalc/widgets/conversions/energy.dart';
import 'package:infinicalc/widgets/conversions/force.dart';
import 'package:infinicalc/widgets/conversions/frequency.dart';
import 'package:infinicalc/widgets/conversions/mass.dart';
import 'package:infinicalc/widgets/conversions/pressure.dart';
import 'package:infinicalc/widgets/conversions/speed.dart';
import 'package:infinicalc/widgets/conversions/time.dart';
import 'package:infinicalc/widgets/conversions/torque.dart';
import 'package:infinicalc/widgets/conversions/volume.dart';
import 'package:infinicalc/widgets/help.dart';
import 'package:infinicalc/widgets/history.dart';
import 'package:infinicalc/widgets/settings.dart';
import 'package:infinicalc/widgets/unit_conversion.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure everything is initialized
  await EasyLocalization.ensureInitialized(); // Initialize EasyLocalization
  runApp(
    EasyLocalization(
      // Wrap your app with EasyLocalization
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'ES'),
        Locale('fr', 'FR'),
        Locale('de', 'DE'),
        Locale('zh', 'CN'),
        Locale('ja', 'JP'),
        Locale('pt', 'BR'),
        Locale('ru', 'RU'),
        Locale('ar', 'SA'),
        Locale('hi', 'IN'),
        Locale('it', 'IT'),
        Locale('ko', 'KR'),
        Locale('th', 'TH'),
        Locale('tr', 'TR'),
        Locale('vi', 'VN')
      ],
      path: 'assets/translations', // Path to your translations folder
      fallbackLocale: const Locale('en',
          'US'), // Fallback locale in case the system locale is not supported
      child: const InfiniCalc(),
    ),
  );
}

class InfiniCalc extends StatelessWidget {
  const InfiniCalc({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = FontSizeProvider();
        // Adding a listener to print the font size whenever it changes
        provider.addListener(() {
          print('Font Size Updated: ${provider.fontSize}');
        });
        return provider;
      },
      child: MaterialApp(
        title: 'InfiniCalc'.tr(), // Use .tr() to translate the app title
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          '/settings': (context) => const SettingsScreen(),
          '/help': (context) => const HelpScreen(),
          '/history': (context) => const HistoryScreen(),
          '/unit': (context) => const UnitConversion(),
          '/distance': (context) => const DistanceUnitConverter(),
          '/area': (context) => const AreaUnitConverter(),
          '/volume': (context) => const VolumeUnitConverter(),
          '/mass': (context) => const MassUnitConverter(),
          '/time': (context) => const TimeUnitConverter(),
          '/speed': (context) => const SpeedUnitConverter(),
          '/frequency': (context) => const FrequencyUnitConverter(),
          '/force': (context) => const ForceUnitConverter(),
          '/torque': (context) => const TorqueUnitConverter(),
          '/pressure': (context) => const PressureUnitConverter(),
          '/energy': (context) => const EnergyUnitConverter(),
          /*'/power': (context) => const PowerUnitConverter(),
          '/temperature': (context) => const TemperatureUnitConverter(),
          '/angle': (context) => const AngleUnitConverter(),
          '/fuel': (context) => const FuelUnitConverter(),
          '/datas': (context) => const DatasUnitConverter(),
          */
        },
        localizationsDelegates:
            context.localizationDelegates, // Add localization delegates
        supportedLocales: context.supportedLocales, // Add supported locales
        locale: context.locale, // Add locale
      ),
    );
  }
}
