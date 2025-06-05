import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/widgets.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: "FAQs",
      ),
      body: Container(),
    );
  }
}
