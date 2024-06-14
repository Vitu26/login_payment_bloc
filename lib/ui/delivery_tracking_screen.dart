import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delivery Tracking')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-23.5505, -46.6333), // Posição inicial
          zoom: 14.0,
        ),
        markers: _createMarkers(),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    // Crie marcadores para a localização do entregador
    return Set<Marker>();
  }
}
