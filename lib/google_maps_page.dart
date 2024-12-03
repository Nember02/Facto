import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatelessWidget {
  const GoogleMapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Начальная позиция камеры
    const LatLng initialPosition = LatLng(37.7749, -122.4194); // Сан-Франциско

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: initialPosition,
          zoom: 12, // Уровень приближения камеры
        ),
        mapType: MapType.normal, // Тип карты: normal, satellite, terrain
        myLocationEnabled: false, // Отображение текущего местоположения
        myLocationButtonEnabled: false, // Кнопка перемещения к текущему местоположению
      ),
    );
  }
}
