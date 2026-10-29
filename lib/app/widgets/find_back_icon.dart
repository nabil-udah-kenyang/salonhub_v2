import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FindBackIcon extends StatelessWidget {
  const FindBackIcon({super.key});

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
