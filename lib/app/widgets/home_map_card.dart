import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class HomeMapCard extends StatelessWidget {
  const HomeMapCard({super.key});

  @override
  Widget build(BuildContext context) {
    const currentLocation = LatLng(-7.7508, 110.3794);
    const barberLocations = [
      LatLng(-7.7489, 110.3778),
      LatLng(-7.7448, 110.3819),
      LatLng(-7.7532, 110.3848),
      LatLng(-7.7583, 110.3782),
      LatLng(-7.7502, 110.3705),
    ];

    return Container(
      height: 155,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.blueGray100,
      ),
      child: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(-7.7505, 110.3797),
              initialZoom: 14.2,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.salonhub.salonhub_v2',
              ),
              MarkerLayer(
                markers: [
                  ...barberLocations.map(
                    (point) => Marker(
                      point: point,
                      width: 36,
                      height: 36,
                      child: const _MapMarker(),
                    ),
                  ),
                  Marker(
                    point: currentLocation,
                    width: 22,
                    height: 22,
                    child: const _CurrentLocationMarker(),
                  ),
                ],
              ),
              RichAttributionWidget(
                attributions: [
                  TextSourceAttribution('OpenStreetMap contributors'),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              width: 134,
              height: 42,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.FIND_BARBER),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary900,
                  foregroundColor: AppColors.white,
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cari sekarang',
                      style: AppTextStyles.caption1.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'lib/assets/icons/search-normal-white.svg',
                      width: 16,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.secondary900,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x330F172A),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: SvgPicture.asset(
        'lib/assets/icons/Shop.svg',
        width: 21,
        height: 21,
      ),
    );
  }
}

class _CurrentLocationMarker extends StatelessWidget {
  const _CurrentLocationMarker();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blue500,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
      ),
    );
  }
}
