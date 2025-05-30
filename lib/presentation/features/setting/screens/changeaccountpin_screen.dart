import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ChangeaccountpinScreen extends StatefulWidget {
  const ChangeaccountpinScreen({super.key});

  @override
  State<ChangeaccountpinScreen> createState() => _ChangeaccountpinScreenState();
}

class _ChangeaccountpinScreenState extends State<ChangeaccountpinScreen> {
     final _formKey = GlobalKey<FormState>();
  final bool _isFormValid = false;
  @override
  Widget build(BuildContext context) {
    return   BundlegramScaffold(
      appBar: const BundlegramAppbar(titleText: 'Enter your password',),
      body: 
    Column(
      children: [
             Flexible(
                   child: AppForm(
                    isExpanded: false,
 
                    isActive: _isFormValid,
                    onPressed: (){
                      context.push(RouteConstants.enterPin);
                    }, buttonText: 'Continue', formKey: _formKey,
                    children:   [
                   
 
                      AppTextField(
                                              obscureText: true,
                      hintText: 'Password',
                       validateFunction:Validators.passcode(),
                    ),
                      
                    
 

                   ],),
                 ),
      ],
    )
    ,);
  }
}
