import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class BrowsingClasses {
  final BoxDecoration myBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 1)),
    ],
  );

  Widget textAlign(String textExplain) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          textExplain,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget textHeadAlign(String textHead) {
    return Align(
      alignment: Alignment.topLeft,
      child:  Text(
          textHead,
          style: const TextStyle(
           fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
          ),
        ),
  
    );
  }





  // Parallelogram clipper and firstWidget
  Widget firstWidget(Color iconColor, Color textColor) {
    return ClipPath(
      clipper: ParallelogramClipper(),
      child: Container(
        color: iconColor,
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Text(
          "Premium",
          style: TextStyle(color: textColor, fontSize: 10),
        ),
      ),
    );
  }
}

class LocationPromptWidget extends StatefulWidget {
  final Function(String) onLocationSelected;

  const LocationPromptWidget({super.key, required this.onLocationSelected});

  @override
  State<LocationPromptWidget> createState() => _LocationPromptWidgetState();
}

class _LocationPromptWidgetState extends State<LocationPromptWidget> {
  bool _isLoading = false;

  Future<void> _getLocation() async {
    if (!mounted) return; // ✅ Guard before doing anything
    setState(() => _isLoading = true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!mounted) return;

      if (!serviceEnabled) {
        widget.onLocationSelected('Unknown');

        if (mounted && ScaffoldMessenger.maybeOf(context) != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location services are disabled.')),
          );
        }

        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (!mounted) return;

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (!mounted) return;

        if (permission == LocationPermission.denied) {
          widget.onLocationSelected('Unknown');

          if (mounted && ScaffoldMessenger.maybeOf(context) != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Location permission denied')),
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        widget.onLocationSelected('Unknown');

        if (mounted && ScaffoldMessenger.maybeOf(context) != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Location permissions are permanently denied. Please enable them in settings.',
              ),
            ),
          );
        }
        return;
      }

      const locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
      );

      final position = await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
      if (!mounted) return;

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!mounted) return;

      final city = placemarks.first.locality ?? 'Unknown city';
      final country = placemarks.first.country ?? 'Unknown country';

      widget.onLocationSelected('$city, $country');
    } catch (e) {
      if (mounted && ScaffoldMessenger.maybeOf(context) != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _getLocation,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: _isLoading
            ? const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Getting location...",
                    style: TextStyle(color: Colors.pink),
                  ),
                ],
              )
            : const Text(
                "Add new location",
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double slant = 3;
    Path path = Path();
    path.moveTo(slant, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - slant, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Placeholder membership widget
class PlaceholderMemberShip extends StatelessWidget {
  final String textDesc;
  final Widget? pallalogramBox;
  final Color iconColor;

  const PlaceholderMemberShip({
    super.key,
    this.pallalogramBox,
    required this.iconColor,
    required this.textDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_fire_department, color: iconColor, size: 25),
                const Text(
                  "tinder",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                pallalogramBox ?? const SizedBox(),
              ],
            ),
            if (textDesc.isNotEmpty)
              Text(textDesc, style: const TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
