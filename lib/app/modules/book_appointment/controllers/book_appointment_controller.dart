import 'package:get/get.dart';
import 'package:salonhub_v2/app/routes/app_pages.dart';

class AppointmentStylist {
  const AppointmentStylist({
    required this.name,
    required this.specialty,
    required this.image,
  });

  final String name;
  final String specialty;
  final String image;
}

class AppointmentService {
  const AppointmentService({
    required this.name,
    required this.price,
    required this.description,
  });

  final String name;
  final int price;
  final String description;
}

class BookAppointmentController extends GetxController {
  final RxInt selectedDate = 15.obs;
  final selectedStylistIndex = 0.obs;
  final selectedServiceIndexes = <int>{0}.obs;
  final selectedTime = '08.00'.obs;

  final displayedMonth = DateTime(2026, 1).obs;

  final stylists = const [
    AppointmentStylist(
      name: 'Alan',
      specialty: 'Potong rambut',
      image: 'lib/assets/barbershop_haircut_2.jpg',
    ),
    AppointmentStylist(
      name: 'Robert',
      specialty: 'Styling',
      image: 'lib/assets/barbershop_exterior_1.jpg',
    ),
    AppointmentStylist(
      name: 'Sergio',
      specialty: 'Pewarnaan',
      image: 'lib/assets/barbershop_haircut_1.jpg',
    ),
    AppointmentStylist(
      name: 'Karl',
      specialty: 'Perawatan',
      image: 'lib/assets/barbershop_interior_2.jpg',
    ),
  ];

  final services = const [
    AppointmentService(
      name: 'Potong rambut dasar',
      price: 20000,
      description: 'Potong rambut & vitamin',
    ),
    AppointmentService(
      name: 'Potong rambut anak',
      price: 15000,
      description: 'Potong rambut anak',
    ),
    AppointmentService(
      name: 'Pewarnaan rambut',
      price: 30000,
      description: 'Warna rambut pilihan',
    ),
    AppointmentService(
      name: 'Perawatan rambut',
      price: 10000,
      description: 'Perawatan rambut',
    ),
    AppointmentService(
      name: 'Cuci rambut',
      price: 10000,
      description: 'Keramas & pengeringan',
    ),
  ];

  final availableTimes = const [
    '08.00',
    '08.30',
    '09.00',
    '09.30',
    '10.00',
    '10.30',
    '11.30',
    '13.00',
    '15.30',
    '16.00',
    '17.00',
    '17.30',
  ];

  final unavailableTimes = const {'09.00', '16.00'};

  AppointmentStylist get selectedStylist =>
      stylists[selectedStylistIndex.value];

  List<AppointmentService> get selectedServices => services
      .asMap()
      .entries
      .where((entry) => selectedServiceIndexes.contains(entry.key))
      .map((entry) => entry.value)
      .toList();

  String get selectedServiceName =>
      selectedServices.map((service) => service.name).join(', ');

  int get selectedServicesPrice =>
      selectedServices.fold(0, (total, service) => total + service.price);

  void selectDate(int date) {
    selectedDate.value = date;
    update();
  }

  void previousMonth() {
    _changeMonth(-1);
  }

  void nextMonth() {
    _changeMonth(1);
  }

  void _changeMonth(int offset) {
    final currentMonth = displayedMonth.value;
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + offset);
    final daysInNextMonth = DateTime(
      nextMonth.year,
      nextMonth.month + 1,
      0,
    ).day;
    final selectedDay = selectedDate.value.clamp(1, daysInNextMonth).toInt();

    displayedMonth.value = nextMonth;
    selectedDate.value = selectedDay;
    update();
  }

  void selectStylist(int index) {
    selectedStylistIndex.value = index;
    update();
  }

  void selectService(int index) {
    if (selectedServiceIndexes.contains(index)) {
      if (selectedServiceIndexes.length > 1) {
        selectedServiceIndexes.remove(index);
      }
    } else {
      selectedServiceIndexes.add(index);
    }
    update();
  }

  void selectTime(String time) {
    if (!unavailableTimes.contains(time)) {
      selectedTime.value = time;
      update();
    }
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

  String get servicePrice => formatRupiah(selectedServicesPrice);

  String get serviceFeePrice => formatRupiah(25000);

  void submitBooking() {
    Get.toNamed(
      Routes.APPOINTMENT_PAYMENT,
      arguments: {
        'date': selectedDate.value,
        'month': displayedMonth.value,
        'time': selectedTime.value,
        'stylistName': selectedStylist.name,
        'stylistImage': selectedStylist.image,
        'serviceName': selectedServiceName,
        'servicePrice': selectedServicesPrice,
      },
    );
  }
}
