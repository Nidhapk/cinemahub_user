import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_state.dart';

Widget mainPhotoContainer(
    {required BuildContext context, required TheatreModel theatre}) {
  final height = MediaQuery.of(context).size.height;
  return BlocBuilder<TheatreDeatilsBloc, TheatreDetailsStates>(
    builder: (context, state) {
      return Container(
        height: height * 0.4,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(state is ImageContainerSelectedState
                ? state.imageUrl
                : theatre.profileImage),
          ),
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    },
  );
}
