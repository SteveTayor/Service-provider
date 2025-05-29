import 'package:bundlegram/gen/assets.gen.dart';

class OnboardingData {
  static  List<Map<String,String>> walkthrough=[
    {
     'name':'CHEAP Airtime & Data Top-Up',
     'subText':'Recharge and purchase data seamlessly',
    'icon':Assets.images.walkthrough1.path,
    },
    {
     'name':'Bill Payments Made Easy',
     'subText':'Pay utilities and more effortlessly',
    'icon':Assets.images.walkthrough2.path,
    },
    {
     'name':'BECOME A BUNDLEGRAM AGENT',
     'subText':'Enjoy discounted features and benefits',
    'icon':Assets.images.walkthrough3.path,
    },
  ];
  static const String termCondition = "By accessing or using Bundlegram, you acknowledge and agree to these terms. Our services include buying airtime, data, paying bills, and becoming agents.\n\nYou are responsible for maintaining the confidentiality of your account information and must not use the app for unlawful purposes. Payments are processed securely through our platform, and refunds are subject to service providers' policies. Our Privacy Policy governs the collection and use of your personal information.\n\nAll content provided through Bundlegram is our property and protected by copyright laws. We are not liable for any damages arising from the use of our services.\n\nThese terms may be updated without notice. By continuing to use our services, you agree to any changes made. If you have questions, contact us at support@bundlegram.com.\n\nThank you for choosing Bundlegram!";
 static const String privacyPolicy = "Your privacy matters to us. We collect necessary personal data like your name, email, and payment details to provide our services. Your information stays safe with us – we don't share it unless required by law. We use industry-standard security measures to protect data, but remember, no system is completely foolproof.\n\nYou have control over your data – you can access, update, or delete it anytime. If you have questions, reach out to us at support@bundlegram.com.\n\nThanks for trusting Bundlegram with your information!";
}
