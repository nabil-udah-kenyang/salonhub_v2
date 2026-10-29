import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class PaymentMethod {
  const PaymentMethod({
    required this.name,
    required this.description,
    required this.image,
  });

  final String name;
  final String description;
  final String image;
}

class AppointmentPaymentController extends GetxController {
  final selectedPaymentIndex = 0.obs;

  DateTime appointmentMonth = DateTime(2026, 1);
  int appointmentDate = 15;
  String appointmentTime = '08.00';
  String stylistName = 'Alan';
  String stylistImage = 'lib/assets/barbershop_haircut_2.jpg';
  String serviceName = 'Potong rambut dasar';
  int servicePrice = 20000;

  final serviceFeePrice = 25000;

  final paymentMethods = const [
    PaymentMethod(
      name: 'QRIS',
      description: 'Scan kode QR dengan aplikasi pembayaran',
      image: 'lib/assets/icons/QRIS Logo - Black - zonalogo.com.svg',
    ),
    PaymentMethod(
      name: 'BCA',
      description: 'Transfer melalui Bank BCA',
      image:
          'lib/assets/icons/Bank Central Asia (BCA) Logo - Colored - zonalogo.com.svg',
    ),
    PaymentMethod(
      name: 'Mandiri',
      description: 'Transfer melalui Bank Mandiri',
      image: 'lib/assets/icons/Bank Mandiri Logo - Colored - zonalogo.com.svg',
    ),
    PaymentMethod(
      name: 'BRI',
      description: 'Transfer melalui Bank BRI',
      image:
          'lib/assets/icons/Bank Rakyat Indonesia (BRI) Logo - Vertical Colored - zonalogo.com.svg',
    ),
    PaymentMethod(
      name: 'BNI',
      description: 'Transfer melalui Bank BNI',
      image:
          'lib/assets/icons/Bank Negara Indonesia (BNI) Logo - Colored - zonalogo.com.svg',
    ),
  ];

  static const _dayNames = [
    'Minggu',
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
  ];

  static const _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  void onInit() {
    _readAppointmentArguments();
    super.onInit();
  }

  int get totalPrice => servicePrice + serviceFeePrice;

  String get appointmentDateLabel {
    final date = DateTime(
      appointmentMonth.year,
      appointmentMonth.month,
      appointmentDate,
    );
    final dayName = _dayNames[date.weekday % 7];
    final monthName = _monthNames[date.month - 1];

    return '$dayName, ${date.day} $monthName ${date.year} - '
        '$appointmentTime WIB';
  }

  String get bookingCode {
    final date = DateTime(
      appointmentMonth.year,
      appointmentMonth.month,
      appointmentDate,
    );
    final year = (date.year % 100).toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final time = appointmentTime.replaceAll('.', '');

    return 'SBH-$year$month$day-$time';
  }

  void selectPayment(int index) {
    selectedPaymentIndex.value = index;
    update();
  }

  void proceedToPayment() {
    final method = paymentMethods[selectedPaymentIndex.value];

    Get.toNamed(
      Routes.PAYMENT,
      arguments: {
        'methodName': method.name,
        'methodImage': method.image,
        'bookingCode': bookingCode,
        'totalPrice': totalPrice,
        'appointmentDateLabel': appointmentDateLabel,
        'stylistName': stylistName,
        'stylistImage': stylistImage,
        'serviceName': serviceName,
        'servicePrice': servicePrice,
        'serviceFeePrice': serviceFeePrice,
      },
    );
  }

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

  void _readAppointmentArguments() {
    final arguments = Get.arguments;
    if (arguments is! Map) {
      return;
    }

    final month = arguments['month'];
    if (month is DateTime) {
      appointmentMonth = DateTime(month.year, month.month);
    }

    final date = arguments['date'];
    if (date is int) {
      appointmentDate = date;
    }

    final time = arguments['time'];
    if (time is String) {
      appointmentTime = time;
    }

    final selectedStylistName = arguments['stylistName'];
    if (selectedStylistName is String) {
      stylistName = selectedStylistName;
    }

    final selectedStylistImage = arguments['stylistImage'];
    if (selectedStylistImage is String) {
      stylistImage = selectedStylistImage;
    }

    final name = arguments['serviceName'];
    if (name is String) {
      serviceName = name;
    }

    final price = arguments['servicePrice'];
    if (price is int) {
      servicePrice = price;
    }
  }
}
