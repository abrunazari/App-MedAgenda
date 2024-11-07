import 'package:app_medagenda/core/widgets/custom-app-bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? floatingActionButton;
  final bool preventBackButton;

  const MainLayout({
    super.key,
    this.title,
    required this.body,
    this.floatingActionButton,
    this.preventBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) return _buildMobileLayout(title, body);
        return _buildDesktopLayout(title, body);
      },
    );
  }

  Widget _buildMobileLayout(String? title, Widget body) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const CustomAppBar(),
          SliverFillRemaining(
            child: body,
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }

  Widget _buildDesktopLayout(String? title, Widget body) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  const CustomAppBar(),
                  SliverFillRemaining(
                    child: body,
                  ),
                ],
              ),
              floatingActionButton: floatingActionButton,
            ),
          ),
        ],
      ),
    );
  }
}
