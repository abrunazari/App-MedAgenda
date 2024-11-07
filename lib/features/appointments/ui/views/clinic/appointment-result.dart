import 'package:app_medagenda/core/constants/color.dart';
import 'package:app_medagenda/core/routes/app-routes.dart';
import 'package:app_medagenda/core/widgets/layout.dart';
import 'package:app_medagenda/core/widgets/primary-button.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppointmentResultContainer extends StatefulWidget {
  final bool isSuccess;

  const AppointmentResultContainer({
    Key? key,
    required this.isSuccess,
  }) : super(key: key);

  @override
  _AppointmentResultContainerState createState() =>
      _AppointmentResultContainerState();
}

class _AppointmentResultContainerState extends State<AppointmentResultContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;
  late ConfettiController _confettiController;

  String clinicId = '';

  @override
  void initState() {
    super.initState();

    clinicId = Get.parameters['clinicId'] ?? '';

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(begin: widget.isSuccess ? 0.5 : 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.isSuccess ? Curves.elasticOut : Curves.easeOut,
      ),
    );

    _shakeAnimation = Tween<double>(begin: -10.0, end: 10.0)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_animationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    if (widget.isSuccess) {
      _confettiController.play();
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void clearStoredData() {
    final box = GetStorage();
    box.erase();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.translate(
                          offset: Offset(
                              widget.isSuccess ? 0 : _shakeAnimation.value, 0),
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: Icon(
                              widget.isSuccess
                                  ? Icons.check_circle
                                  : Icons.error,
                              color:
                                  widget.isSuccess ? Colors.green : Colors.red,
                              size: 100,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.isSuccess
                              ? 'Agendamento Confirmado'
                              : 'Falha ao Agendar',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.main),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  AppColors.aquaGreen,
                  AppColors.mainSoft,
                  AppColors.orange,
                  AppColors.main,
                  AppColors.yellow,
                  AppColors.secondary,
                  AppColors.mainDark,
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryButton(
            onPressed: () {
              clearStoredData();
              Get.offAllNamed(
                Routes.CLINIC.replaceFirst(':clinicId', clinicId),
              );
            },
            text: 'Fazer Novo Agendamento',
            height: 60,
          ),
        ),
      ),
    );
  }
}
