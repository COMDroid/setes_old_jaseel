import 'package:geolocator/geolocator.dart';

String gbUserId = '';
bool gbisGuest = true;
bool gbisPrime = false;

Map gbUser = {};

bool upgradingtoPrime = false;

Map<String, String> gbHeader = {};

const gbVersion = 1;

Position gbGPS = Position(
  longitude: 1,
  latitude: 1,
  timestamp: DateTime.now(),
  accuracy: 1,
  altitude: 1,
  heading: 1,
  speed: 1,
  speedAccuracy: 1,
);
