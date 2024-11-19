import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:userside/presentation/screens/profile/privacy_policy/widget/sub_content.dart';


Widget subContents({
  required BuildContext context,
  required final List<Map<String, String>> contentItems,
  required int itemCount,
}) {
  
  return ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: itemCount,
    itemBuilder: (context, index) {
      final item = contentItems[index];
      return subContent(
        title: item['title'] ?? '',
        subtitle: item['subtitle'] ?? '',
      );
    },
  );
}
