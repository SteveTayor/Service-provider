
// ignore_for_file: prefer_asserts_with_message

import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_button.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppForm extends StatefulWidget {
  const AppForm({required this.children, 
  required this.isActive,
  required this.formKey, required this.onPressed, required this.buttonText, super.key,});
  final List<AppTextField>  children;
  final VoidCallback onPressed;
  final String buttonText;
  final bool isActive;

 final GlobalKey<FormState> formKey;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
 

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(widget.children.length, (index){
                  return widget.children[index].withContainer(padding: EdgeInsets.only(bottom: 28.h));
                }),
              ),
            ),
          ),
          32.verticalSpace,
          
          Opacity(
            opacity: widget.isActive?1:0.5,
            child: BundlegramButton(
              
              color:
             
              
              
               AppColors.primaryColor,
               
               
              text: widget.buttonText,
             onPressed: (){
                           widget.formKey.currentState!.validate();
             },),
          ),
        ],
      ),
    );
  }
}
