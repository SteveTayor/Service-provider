import 'package:bundlegram/Core/extensions/context_extensions.dart';
import 'package:bundlegram/presentation/app.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BundlegramScaffold extends StatelessWidget {
  const BundlegramScaffold({
    required this.body,
    super.key,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.footerButton,
    this.underFooterChild,
    this.extendBody = false,
    this.backgroundColor,
    this.backgroundImage,
    this.showBackImage = true,
    this.footerPadding,
    this.sidePadding,
    this.appBar,
  });
  final Widget body;
  final bool? resizeToAvoidBottomInset;

  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? footerButton;
  final Widget? underFooterChild;
  final EdgeInsetsGeometry? footerPadding;
  final EdgeInsetsGeometry? sidePadding;
  final bool extendBody;
  final Color? backgroundColor;
  final ImageProvider? backgroundImage;
  final bool showBackImage;
  final BundlegramAppbar? appBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerTheme: const DividerThemeData(color: Colors.transparent),
        ),
        child: Scaffold(
          appBar:appBar??const BundlegramAppbar(showBackButton: false,),
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: Padding(
            padding:sidePadding?? const EdgeInsets.all(16),
            child: SizedBox(
              height: context.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (showBackImage)
                    // Positioned.fill(
                    //   child: Image(
                    //     image:
                    //         backgroundImage ?? Assets.images.pattern.provider()
                    //     fit: BoxFit.cover,
                    //     repeat: ImageRepeat.repeat,
                    //   ),
                    // ),
                  body,
                ],
              ),
            ),
          ),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          persistentFooterButtons: (footerButton != null)
              ? [
                  Padding(
                    padding: footerPadding ??
                        EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                    child: Container(
                      margin: context.bottomPaddingForTextField,
                      child: Column(
                        children: [
                          footerButton!,
                          16.verticalSpace,
                          if (underFooterChild != null) underFooterChild!,
                        ],
                      ),
                    ),
                  ),
                ]
              : null,
          extendBody: extendBody,
        ),
      ),
    );
  }
}
