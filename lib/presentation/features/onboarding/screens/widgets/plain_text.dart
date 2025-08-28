import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PlainTextWidget extends StatelessWidget {
  const PlainTextWidget(
      {required this.text, this.highlightHeaders = true, super.key});

  final String text;
  final bool highlightHeaders;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: 48,
        ),
        child: Column(
          children: [
            _buildStyledText(context),
            40.verticalSpace,
            BundlegramButton(text: 'Close', onPressed: () => context.pop()),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledText(BuildContext context) {
    if (!highlightHeaders) {
      return Text(
        text,
        textAlign: TextAlign.justify,
        style: context.textTheme.bodySmall!.copyWith(
          color: AppColors.grey33,
          height: 30 / 18,
        ),
      );
    }

    // Split text and apply styles with mixed alignment
    return _buildMixedAlignmentText(context);
  }

  Widget _buildMixedAlignmentText(BuildContext context) {
    final baseStyle = context.textTheme.bodySmall!.copyWith(
      color: AppColors.grey33,
      height: 30 / 18,
    );

    final headerStyle = baseStyle.copyWith(
      fontWeight: FontWeight.w900,
      color: AppColors.black,
    );

    final subHeaderStyle = baseStyle.copyWith(
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );

    List<Widget> widgets = [];
    List<String> lines = text.split('\n');
    String currentParagraph = '';
    bool isInRegularText = false;

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];

      // Check if line is a header (all caps with more than 3 characters)
      bool isHeader = line.trim().isNotEmpty &&
          line.trim() == line.trim().toUpperCase() &&
          line.trim().length > 3 &&
          !line.contains('•');

      // Check if line is a sub-header
      bool isSubHeader = line.trim().isNotEmpty &&
          line.trim()[0] == line.trim()[0].toUpperCase() &&
          !line.trim().endsWith('.') &&
          !line.contains('•') &&
          line.trim().length < 50;

      // Check if line is a bullet point
      bool isBulletPoint = line.trim().startsWith('•');

      if (isHeader || isSubHeader || isBulletPoint) {
        // First, add any accumulated regular text as justified
        if (currentParagraph.trim().isNotEmpty) {
          widgets.add(
            Text(
              currentParagraph.trim(),
              textAlign: TextAlign.justify,
              style: baseStyle,
            ),
          );
          currentParagraph = '';
        }

        // Add spacing before headers (but not before the very first widget)
        if (widgets.isNotEmpty) {
          if (isHeader) {
            widgets.add(SizedBox(height: 24.h)); // More space before headers
          } else if (isSubHeader) {
            widgets
                .add(SizedBox(height: 16.h)); // Medium space before sub-headers
          } else {
            widgets
                .add(SizedBox(height: 8.h)); // Small space before bullet points
          }
        }

        // Add the header/subheader/bullet as left-aligned
        TextStyle styleToUse = baseStyle;
        if (isHeader) {
          styleToUse = headerStyle;
        } else if (isSubHeader) {
          styleToUse = subHeaderStyle;
        } else if (isBulletPoint) {
          styleToUse = baseStyle.copyWith(
            color: AppColors.grey2F,
            // fontStyle: FontStyle.italic,
          );
        }

        widgets.add(
          Text(
            line,
            textAlign: TextAlign.left,
            style: styleToUse,
          ),
        );

        // Add spacing after headers
        if (isHeader) {
          widgets.add(SizedBox(height: 12.h)); // Space after headers
        } else if (isSubHeader) {
          widgets.add(SizedBox(height: 8.h)); // Space after sub-headers
        } else {
          widgets.add(SizedBox(height: 4.h)); // Small space after bullet points
        }

        isInRegularText = false;
      } else {
        // Accumulate regular text for justified alignment
        if (line.trim().isNotEmpty) {
          if (currentParagraph.isNotEmpty) {
            currentParagraph += '\n';
          }
          currentParagraph += line;
          isInRegularText = true;
        } else if (isInRegularText && currentParagraph.trim().isNotEmpty) {
          // Empty line - end current paragraph
          widgets.add(
            Text(
              currentParagraph.trim(),
              textAlign: TextAlign.justify,
              style: baseStyle,
            ),
          );
          widgets.add(SizedBox(height: 12.h)); // Space after paragraphs
          currentParagraph = '';
          isInRegularText = false;
        }
      }
    }

    // Add any remaining regular text
    if (currentParagraph.trim().isNotEmpty) {
      widgets.add(
        Text(
          currentParagraph.trim(),
          textAlign: TextAlign.justify,
          style: baseStyle,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
