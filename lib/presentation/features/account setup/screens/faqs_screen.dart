import 'package:bundlegram/data/models/faqs_model.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/accountsetup_data.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  String searchQuery = '';
  List<FAQItem> filteredFAQs = HelpCenterFAQData.faqItems;

  void _filterFAQs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredFAQs = HelpCenterFAQData.faqItems;
      } else {
        filteredFAQs = HelpCenterFAQData.faqItems
            .where((faq) =>
                faq.question.toLowerCase().contains(query.toLowerCase()) ||
                faq.answer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Help center (FAQs)',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            decoration: BoxDecoration(
              color: AppColors.searchbarColor,
              borderRadius: BorderRadius.circular(80.r),
            ),
            child: AppTextField(
              decoration: InputDecoration(
                fillColor: AppColors.searchbarColor,
                filled: true,
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: AppColors.grey8E,
                  ),
                ),
                hintText: 'Search...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.searchHintColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(80.r),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(80.r),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(80.r),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(80.r),
                ),
              ),
              onChange: _filterFAQs,
            ),
            // TextField(
            //   decoration: InputDecoration(
            //     hintText: 'Search...',
            //     hintStyle: TextStyle(
            //       color: AppColors.searchHintColor,
            //       fontSize: 16,
            //     ),
            //     prefixIcon: Icon(
            //       Icons.search,
            //       color: AppColors.searchHintColor,
            //       size: 20,
            //     ),
            //     prefixIconConstraints: BoxConstraints(
            //       minWidth: 48.w,
            //       minHeight: 24.h,
            //     ),
            //     border: InputBorder.none,
            //     contentPadding: EdgeInsets.symmetric(
            //       horizontal: 16.w,
            //       vertical: 8.h,
            //     ),
            //   ),
            // ),
          ),
          Divider(color: Color(0xFFECECEC)),
          // FAQ List
          Expanded(
            child: filteredFAQs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        16.verticalSpace,
                        Text(
                          'No FAQs found',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.grey80,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          'Try adjusting your search terms',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey33,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: filteredFAQs.length,
                    separatorBuilder: (context, index) => 12.verticalSpace,
                    itemBuilder: (context, index) {
                      final faq = filteredFAQs[index];
                      return FAQExpansionTile(
                        question: faq.question,
                        answer: faq.answer,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FAQExpansionTile extends StatelessWidget {
  const FAQExpansionTile({
    required this.question,
    required this.answer,
    super.key,
  });

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      // decoration: BoxDecoration(
      // ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: Column(
          children: [
            ExpansionTile(
              tilePadding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              childrenPadding: EdgeInsets.only(
                left: 10.w,
                right: 10.w,
                bottom: 16.h,
              ),
              title: Text(
                question,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              iconColor: AppColors.black,
              collapsedIconColor: AppColors.black,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    answer,
                    textAlign: TextAlign.justify,
                    style: context.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      // fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Color(0xFFECECEC)),
          ],
        ),
      ),
    );
  }
}
