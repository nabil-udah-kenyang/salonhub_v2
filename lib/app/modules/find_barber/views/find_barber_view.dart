import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:salonhub_v2/app/constant/theme.dart';
import 'package:salonhub_v2/app/models/barber.dart';

import '../controllers/find_barber_controller.dart';

class FindBarberView extends GetView<FindBarberController> {
  const FindBarberView({super.key});

  static const _mapCenter = LatLng(-7.7505, 110.3797);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueGray100,
      body: SafeArea(
        bottom: false,
        child: Obx(
          () => Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  _buildHeader(),
                  Expanded(child: _buildMapArea(context)),
                ],
              ),
              if (controller.showSuccessToast.value)
                _buildSuccessToastOverlay(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: AppColors.blueGray50,
      child: Row(
        children: [
          IconButton(
            onPressed: Get.back,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 40),
            icon: const _BackIcon(),
          ),
          const SizedBox(width: 14),
          Text(
            'Cari barber terdekat',
            style: AppTextStyles.headline4.copyWith(
              color: AppColors.blueGray900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapArea(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          options: const MapOptions(
            initialCenter: _mapCenter,
            initialZoom: 14.2,
            interactionOptions: InteractionOptions(flags: InteractiveFlag.all),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.salonhub.salonhub_v2',
            ),
            Obx(() {
              final routePoints = controller.routePoints.toList();

              if (routePoints.isEmpty) {
                return const SizedBox.shrink();
              }

              return PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints,
                    color: AppColors.primary900,
                    strokeWidth: 4,
                    borderStrokeWidth: 2,
                    borderColor: AppColors.white.withValues(alpha: .82),
                    strokeCap: StrokeCap.round,
                    strokeJoin: StrokeJoin.round,
                  ),
                ],
              );
            }),
            Obx(
              () => MarkerLayer(
                markers: [
                  ...List.generate(
                    controller.markerPositions.length,
                    (index) => Marker(
                      point: controller.markerPositions[index],
                      width: 42,
                      height: 42,
                      child: GestureDetector(
                        onTap: () => controller.selectMarker(index),
                        child: _BarberMarker(
                          active: controller.selectedMarker.value == index,
                        ),
                      ),
                    ),
                  ),
                  Marker(
                    point: controller.currentLocation,
                    width: 26,
                    height: 26,
                    child: const _CurrentLocationMarker(),
                  ),
                ],
              ),
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution('OpenStreetMap contributors'),
              ],
            ),
          ],
        ),
        Positioned(top: 22, left: 16, right: 84, child: _buildLocationSearch()),
        Positioned(top: 22, right: 16, child: _buildMapControls()),
        Positioned.fill(
          child: DraggableScrollableSheet(
            controller: controller.sheetController,
            initialChildSize: .34,
            minChildSize: .24,
            maxChildSize: .82,
            snap: true,
            snapSizes: const [.34, .58, .82],
            builder: (context, scrollController) {
              return Obx(
                () => controller.isSearching.value
                    ? _buildSearchSheet(scrollController)
                    : _buildBarberSheet(scrollController),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSearch() {
    return Material(
      elevation: 5,
      shadowColor: AppColors.blueGray900.withValues(alpha: .14),
      borderRadius: BorderRadius.circular(9),
      color: AppColors.blueGray50,
      child: SizedBox(
        height: 46,
        child: TextField(
          controller: controller.locationSearchController,
          onTap: controller.openSearch,
          onChanged: controller.changeLocationQuery,
          textInputAction: TextInputAction.search,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            hintText: 'Cari lokasi',
            hintStyle: AppTextStyles.body3.copyWith(
              color: AppColors.primary500,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset(
                'lib/assets/icons/search-normal.svg',
                width: 20,
                height: 20,
              ),
            ),
            filled: false,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildMapControls() {
    return Material(
      elevation: 4,
      shadowColor: AppColors.blueGray900.withValues(alpha: .12),
      borderRadius: BorderRadius.circular(9),
      color: AppColors.blueGray50,
      child: SizedBox(
        width: 44,
        height: 92,
        child: Column(
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'lib/assets/icons/Map Arrow Square.svg',
                  width: 26,
                  height: 26,
                ),
              ),
            ),
            Container(height: 1, color: AppColors.blueGray200),
            Expanded(
              child: IconButton(
                onPressed: controller.showLocationSuccess,
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  'lib/assets/icons/GPS.svg',
                  width: 26,
                  height: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessToastOverlay(BuildContext context) {
    final toastWidth = (MediaQuery.sizeOf(context).width - 48)
        .clamp(0.0, 272.0)
        .toDouble();

    return Stack(
      children: [
        const Positioned.fill(child: ColoredBox(color: Color(0x660F172A))),
        Positioned(
          left: 0,
          right: 0,
          bottom: 34,
          child: Center(
            child: SizedBox(
              width: toastWidth,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 10, 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F9F8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x330F172A),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/icons/material-symbols_check-circle-rounded.svg',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Berhasil', style: AppTextStyles.caption1),
                          SizedBox(height: 2),
                          Text(
                            'Lokasi berhasil diperbarui',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.caption2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: controller.hideSuccessToast,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: SvgPicture.asset(
                          'lib/assets/icons/Close Square.svg',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBarberSheet(ScrollController scrollController) {
    return Material(
      color: const Color(0xFFF1F9F8),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(18, 10, 0, 18),
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 42,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.coolGray300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                'lib/assets/icons/Map Point.svg',
                width: 19,
                height: 19,
              ),
              const SizedBox(width: 6),
              Text(
                'Alfamart Jakal',
                style: AppTextStyles.headline4.copyWith(
                  color: AppColors.blueGray900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Text(
              'Jl. Kaliurang Km. 9,5, Ngaglik, Kabupaten Sleman',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body3.copyWith(color: AppColors.blueGray500),
            ),
          ),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Divider(height: 1, color: AppColors.blueGray200),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 92,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(right: 18),
              itemCount: controller.nearbyBarbers.length,
              separatorBuilder: (_, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return _NearbyBarberCard(
                  barber: controller.nearbyBarbers[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSheet(ScrollController scrollController) {
    return Material(
      color: const Color(0xFFF1F9F8),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
        children: [
          Text(
            'Pencarian terakhir',
            style: AppTextStyles.headline4.copyWith(
              color: AppColors.blueGray900,
            ),
          ),
          const SizedBox(height: 10),
          if (controller.filteredRecentSearches.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Lokasi tidak ditemukan',
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.blueGray500,
                ),
              ),
            )
          else
            ...List.generate(
              controller.filteredRecentSearches.length,
              (index) => _RecentSearchItem(
                name: controller.filteredRecentSearches[index].name,
                address: controller.filteredRecentSearches[index].address,
                selected: controller.selectedRecentSearch.value == index,
                onTap: () => controller.selectRecentSearch(index),
              ),
            ),
          const SizedBox(height: 18),
          SizedBox(
            height: 55,
            child: FilledButton.icon(
              onPressed: controller.closeSearch,
              icon: SvgPicture.asset(
                'lib/assets/icons/GPS.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
                  BlendMode.srcIn,
                ),
              ),
              label: Text(
                'Atur lokasi',
                style: AppTextStyles.subHeadline3.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary900,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BarberMarker extends StatelessWidget {
  const _BarberMarker({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: active ? 42 : 38,
      height: active ? 42 : 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.primary900 : AppColors.secondary900,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.white, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330F172A),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SvgPicture.asset(
        'lib/assets/icons/Shop.svg',
        width: 25,
        height: 25,
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
        border: Border.all(color: AppColors.white, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x440F172A),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class _NearbyBarberCard extends StatelessWidget {
  const _NearbyBarberCard({required this.barber});

  final Barber barber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.blueGray50,
        borderRadius: BorderRadius.circular(9),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F172A),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              barber.image,
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  barber.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.subHeadline3.copyWith(
                    color: AppColors.blueGray900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                _MetaLine(
                  iconAsset: 'lib/assets/icons/Map Point.svg',
                  text: '${barber.description} (${barber.distance})',
                ),
                const SizedBox(height: 5),
                _MetaLine(
                  iconAsset: 'lib/assets/icons/Star.svg',
                  text: '${barber.rating}  (24)',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconAsset, width: 14, height: 14),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.caption1.copyWith(color: AppColors.primary500),
          ),
        ),
      ],
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  const _RecentSearchItem({
    required this.name,
    required this.address,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final String address;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.blueGray100 : Colors.transparent,
          border: selected
              ? Border.all(color: AppColors.primary900, width: 1.5)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SvgPicture.asset(
                'lib/assets/icons/Map Point.svg',
                width: 17,
                height: 17,
              ),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.subHeadline2.copyWith(
                      color: AppColors.blueGray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body3.copyWith(
                      color: AppColors.blueGray500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackIcon extends StatelessWidget {
  const _BackIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '''
<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
  <path d="M19 12H5M5 12L11 6M5 12L11 18" stroke="#0F172A" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''',
      width: 24,
      height: 24,
    );
  }
}
