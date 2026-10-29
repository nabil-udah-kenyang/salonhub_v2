import 'package:get/get.dart';
import 'package:salonhub_v2/app/data/receipt_download_service.dart';

class InvoiceController extends GetxController {
  String appointmentDateLabel = 'Kamis, 15 Januari 2026 - 08.00 WIB';
  String serviceName = 'Potong rambut dasar';
  int servicePrice = 20000;
  int serviceFeePrice = 25000;
  int totalPrice = 45000;
  String bookingCode = 'SBH-260115-0800';
  String paymentMethodName = 'QRIS';
  bool isDownloading = false;

  final ReceiptDownloadService _receiptDownloadService =
      ReceiptDownloadService();

  @override
  void onInit() {
    _readInvoiceArguments();
    super.onInit();
  }

  String get bookingDate => appointmentDateLabel.split(' - ').first;

  String formatRupiah(int amount) {
    final digits = amount.toString();
    final formatted = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      if (index > 0 && (digits.length - index) % 3 == 0) {
        formatted.write('.');
      }
      formatted.write(digits[index]);
    }

    return 'Rp$formatted';
  }

  Future<void> downloadReceipt() async {
    if (isDownloading) {
      return;
    }

    isDownloading = true;
    update();

    try {
      await _receiptDownloadService.download(
        ReceiptData(
          bookingCode: bookingCode,
          appointmentDateLabel: appointmentDateLabel,
          paymentMethodName: paymentMethodName,
          serviceName: serviceName,
          servicePrice: servicePrice,
          serviceFeePrice: serviceFeePrice,
          totalPrice: totalPrice,
        ),
      );
      Get.snackbar(
        'Struk berhasil diunduh',
        'Bukti pembayaran $bookingCode telah disimpan sebagai PDF.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (_) {
      Get.snackbar(
        'Unduh gagal',
        'Bukti pembayaran belum dapat disimpan. Silakan coba lagi.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isDownloading = false;
      update();
    }
  }

  void _readInvoiceArguments() {
    final arguments = Get.arguments;
    if (arguments is! Map) {
      return;
    }

    final dateLabel = arguments['appointmentDateLabel'];
    if (dateLabel is String) {
      appointmentDateLabel = dateLabel;
    }

    final code = arguments['bookingCode'];
    if (code is String) {
      bookingCode = code;
    }

    final method = arguments['paymentMethodName'];
    if (method is String) {
      paymentMethodName = method;
    }

    final selectedServiceName = arguments['serviceName'];
    if (selectedServiceName is String) {
      serviceName = selectedServiceName;
    }

    final selectedServicePrice = arguments['servicePrice'];
    if (selectedServicePrice is int) {
      servicePrice = selectedServicePrice;
    }

    final feePrice = arguments['serviceFeePrice'];
    if (feePrice is int) {
      serviceFeePrice = feePrice;
    }

    final total = arguments['totalPrice'];
    if (total is int) {
      totalPrice = total;
    }
  }
}
