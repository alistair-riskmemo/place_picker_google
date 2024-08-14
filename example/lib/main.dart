import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_place_picker/google_place_picker.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Place Picker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GooglePlacePickerExample(),
    );
  }
}

class GooglePlacePickerExample extends StatefulWidget {
  const GooglePlacePickerExample({super.key});

  @override
  State<GooglePlacePickerExample> createState() =>
      _GooglePlacePickerExampleState();
}

class _GooglePlacePickerExampleState extends State<GooglePlacePickerExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Pick Delivery location"),
          onPressed: () {
            showPlacePicker();
          },
        ),
      ),
    );
  }

  void showPlacePicker() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return Scaffold(
            // appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: PlacePicker(
                    apiKey: Platform.isAndroid
                        ? FlutterConfig.get('GOOGLE_MAPS_API_KEY_ANDROID')
                        : FlutterConfig.get('GOOGLE_MAPS_API_KEY_IOS'),
                    onPlacePicked: (LocationResult result) {
                      debugPrint("Place picked: ${result.formattedAddress}");
                      Navigator.of(context).pop();
                    },
                    showNearbyPlaces: false,
                    initialLocation: const LatLng(
                      29.378586,
                      47.990341,
                    ),
                    searchInputPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    searchInputBorderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                ),
                // Container(height: 100, )
              ],
            ),
          );
        },
      ),
    );
  }
}
