import 'package:flutter/material.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/widget/details.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/widget/photo_gallery.dart';

class TheatreDetailsScreen extends StatelessWidget {
  final TheatreModel theatre;
  const TheatreDetailsScreen({super.key, required this.theatre});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(
          width * 0.05,
        ),
        children: [
          photoGallery(
            context: context,
            theatre: theatre,
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            theatre.name,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: width * 0.05,
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          theatreDetailsInDetailPage(
            context: context,
            icon: Icons.location_on,
            color: Colors.indigo,
            text: theatre.address,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          theatreDetailsInDetailPage(
              context: context,
              icon: Icons.phone,
              color: Colors.green,
              text: theatre.phone),
          SizedBox(
            height: height * 0.01,
          ),
          theatreDetailsInDetailPage(
            context: context,
            icon: Icons.email,
            color: const Color.fromARGB(
              255,
              117,
              117,
              117,
            ),
            text: theatre.emailId,
          ),
        ],
      ),
    );
  }
}
