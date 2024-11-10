import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/features/appointments/ui/controllers/consult-details-controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class DateCarousel extends GetView<DateCarouselController> {
  final List<DateTime> dates;

  const DateCarousel({Key? key, required this.dates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateCarouselController>(
      init: DateCarouselController(),
      builder: (controller) => Column(
        children: <Widget>[
          CarouselSlider(
            items: dates.map((date) {
              return Builder(
                builder: (BuildContext context) {
                  return DateChip(
                    date: date,
                    isSelected: controller.isSelectedDate(date),
                    onTap: () => controller.handleDateTap(date),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: controller.current,
              enableInfiniteScroll: false,
              viewportFraction: 0.3,
              height: 90,
              onPageChanged: (index, reason) {
                controller.setCurrentIndex(index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DateChip extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  const DateChip({
    Key? key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dayOfWeek = DateFormat('EEE', 'pt_BR').format(date);
    final dayOfMonth = DateFormat('d').format(date);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              dayOfWeek,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? AppColors.main : Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.main.withOpacity(0.8)
                    : AppColors.grey50.withOpacity(0.5),
                boxShadow: isSelected
                    ? [BoxShadow(color: Colors.grey.shade400, blurRadius: 5)]
                    : [],
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Text(
                  dayOfMonth,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 18,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCarouselController extends GetxController {
  int current = 3;

  @override
  void onInit() {
    super.onInit();
    initializeSelectedDate();
  }

  void initializeSelectedDate() {
    final consultDetailsController = Get.find<ConsultDetailsController>();
    final selectedDateString = consultDetailsController.selectedDate.value;
    if (selectedDateString.isNotEmpty) {
      final selectedDate = DateFormat('yyyy-MM-dd').parse(selectedDateString);
      final index = consultDetailsController.availableDates
          .indexOf(DateFormat('yyyy-MM-dd').format(selectedDate));
      if (index != -1) {
        current = index;
      }
    }
    update();
  }

  void setCurrentIndex(int index) {
    current = index;
    update();
  }

  void handleDateTap(DateTime date) {
    String formattedDate = date.toIso8601String();

    final consultDetailsController = Get.find<ConsultDetailsController>();
    consultDetailsController.handleDateSelection(formattedDate);
    update();
  }

  bool isSelectedDate(DateTime date) {
    final consultDetailsController = Get.find<ConsultDetailsController>();
    final selectedDate = DateFormat('yyyy-MM-dd')
        .parse(consultDetailsController.selectedDate.value);
    return DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(selectedDate);
  }

  Widget buildDateChip(DateTime date, BuildContext context) {
    String dayOfWeek = DateFormat('EEE', 'pt_BR').format(date);
    dayOfWeek = dayOfWeek.replaceAll(RegExp(r'\.$'), '');
    final dayOfMonth = DateFormat('d').format(date);

    final isSelected = isSelectedDate(date);
    final backgroundColor = isSelected
        ? AppColors.main.withOpacity(0.8)
        : AppColors.grey50.withOpacity(0.5);
    final textColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () => handleDateTap(date),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(dayOfWeek, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            CircleAvatar(
              radius: 18,
              backgroundColor: backgroundColor,
              child: textColor == Colors.white
                  ? Text(dayOfMonth,
                      style: const TextStyle(color: Colors.white, fontSize: 18))
                  : Text(dayOfMonth,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
