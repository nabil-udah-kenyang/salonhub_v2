import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salonhub_v2/app/constant/theme.dart';

class InvoiceActionButtons extends StatelessWidget {
  const InvoiceActionButtons({
    super.key,
    required this.onBack,
    required this.onDownload,
    required this.isDownloading,
  });

  final VoidCallback onBack;
  final VoidCallback onDownload;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 44,
            child: FilledButton(
              onPressed: onBack,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary900,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: Text(
                'Kembali',
                style: AppTextStyles.headline5.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 44,
            child: OutlinedButton(
              onPressed: isDownloading ? null : onDownload,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary900,
                side: const BorderSide(color: AppColors.primary900),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: isDownloading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary900,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Unduh',
                          style: AppTextStyles.headline5.copyWith(
                            color: AppColors.primary900,
                          ),
                        ),
                        const SizedBox(width: 6),
                        SvgPicture.asset(
                          'lib/assets/icons/Cloud Download.svg',
                          width: 17,
                          height: 17,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
