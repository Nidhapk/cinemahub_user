import 'package:flutter/material.dart';
import 'package:userside/presentation/screens/profile/privacy_policy/widget/policy_contents.dart';
import 'package:userside/presentation/screens/profile/privacy_policy/widget/sub_contents.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      //  backgroundColor: Color.fromARGB(255, 17, 17, 17),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: width * 0.05),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(width * 0.05),
            child:const  Text(
                '\t\t\t\t\tThank you for using CinemaHub. We value your privacy and are committed to protecting your personal information. This Privacy Policy explains how we collect, use, share, and protect information about you when you use our cinema ticket booking application CinemaHub.'),
          ),
          policyContents(
            context: context,
            mainHeading: '1. Information We Collect',
            introduction:
                'When you use our App, we may collect certain information, including:',
            subcontents: subContents(
                context: context,
                contentItems: personalInformation,
                itemCount: 4),
          ),
          policyContents(
              context: context,
              mainHeading: '2. How We Use the Information',
              introduction:
                  'We may use the information we collect for purposes such as:',
              subcontents: subContents(
                  context: context,
                  itemCount: 5,
                  contentItems: useOfInformation)),
          policyContents(
            context: context,
            mainHeading: 'Information Sharing and Disclosure',
            introduction: 'We may share your information with:',
            subcontents: subContents(
                context: context, contentItems: informationShare, itemCount: 3),
          ),
          policyContents(
            context: context,
            mainHeading: '4. Data Security',
            introduction:
                'We implement appropriate security measures to protect your information from unauthorized access, alteration, or disclosure. However, no internet-based service can be 100% secure, and we cannot guarantee the absolute security of your data.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
            context: context,
            mainHeading: '5. Your Choices',
            introduction: '',
            subcontents: subContents(
                context: context, contentItems: yourChoices, itemCount: 1),
          ),
          policyContents(
            context: context,
            mainHeading: '6. Third-Party Links',
            introduction:
                'The App may contain links to third-party websites or services. We are not responsible for the privacy practices of these third-party services, and we encourage you to read their privacy policies.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
            context: context,
            mainHeading: '7. Children’s Privacy',
            introduction:
                'Our App is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If we learn we have collected information from a child under 13, we will promptly delete that information.',
            subcontents: const SizedBox.shrink(),
          ),
          policyContents(
              context: context,
              mainHeading: '8. Changes to This Privacy Policy',
              introduction:
                  'We may update this Privacy Policy from time to time. Any changes will be posted in the App, and we encourage you to review the Privacy Policy regularly.',
              subcontents: const SizedBox.shrink()),
          policyContents(
            context: context,
            mainHeading: '9. Contact Us',
            introduction:
                'If you have questions about this Privacy Policy or our data practices, please contact us at :',
            subcontents: const SizedBox.shrink(),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05, bottom: width * 0.1),
            child: const Text.rich(TextSpan(
                text: 'Email: ',
                style: TextStyle(fontWeight: FontWeight.bold),
                children: [TextSpan(text: 'pknidhanidh@gmail.com')])),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> personalInformation = [
  {
    'title': 'Personal Information: ',
    'subtitle':
        ' Information such as your name, email address, phone number, and payment details that you provide when you register, book tickets, or update your profile.'
  },
  {
    'title': 'Device Information: ',
    'subtitle':
        ' Details about the device you use to access the App, such as the device type, operating system, IP address, and app usage data.'
  },
  {
    'title': 'Location Information: ',
    'subtitle':
        ' If you permit it, we may collect your location data to show nearby theatres and personalized content.'
  },
  {
    'title': 'Payment Information: ',
    'subtitle':
        'When you make a booking, we collect payment information, but please note that all payment transactions are processed by a secure third-party payment gateway.'
  },
];
final List<Map<String, String>> useOfInformation = [
  {
    'title': 'a. ',
    'subtitle': 'Facilitating ticket bookings and other transactions.'
  },
  {
    'title': 'b. ',
    'subtitle':
        'Personalizing your experience, such as recommending movies and theatres.'
  },
  {
    'title': 'c. ',
    'subtitle': 'Improving the App’s features, performance, and user interface.'
  },
  {
    'title': 'd. ',
    'subtitle': 'Providing customer support and responding to your inquiries.'
  },
  {
    'title': 'e. ',
    'subtitle':
        'Communicating with you about updates, promotions, or other information relevant to your use of the App.'
  },
];
final List<Map<String, String>> informationShare = [
  {
    'title': 'Service Providers: ',
    'subtitle':
        'Third-party companies that assist us in operating the App, processing payments, and providing customer support.'
  },
  {
    'title': 'Theatres: ',
    'subtitle':
        'We may share certain booking details with the theatre where you booked your ticket.'
  },
  {
    'title': 'Legal Requirements: ',
    'subtitle':
        'In response to a legal request, such as a subpoena, court order, or law enforcement request, if required by law.'
  },
];
final List<Map<String, String>> yourChoices = [
  {
    'title': 'Location: ',
    'subtitle':
        'You can manage the App’s access to your location data in your device settings.'
  },
];
