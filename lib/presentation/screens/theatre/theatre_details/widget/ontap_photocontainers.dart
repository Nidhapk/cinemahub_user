import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_state.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget onTapPhotoContainers(
    {required BuildContext context, required TheatreModel theatre}) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(bottom: height * 0.03),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      height: width * 0.2,
      child: theatre.images.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              padding: EdgeInsets.all(height * 0.005),
              // addRepaintBoundaries: true,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: theatre.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => context.read<TheatreDeatilsBloc>().add(
                      ImageContainerTapedEvent(
                          index,
                          index == 0
                              ? theatre.profileImage
                              : theatre.images[index - 1])),
                  child: BlocBuilder<TheatreDeatilsBloc, TheatreDetailsStates>(
                    builder: (context, state) {
                      return Container(
                        height: width * 0.2,
                        width: width * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(index == 0
                                ? theatre.profileImage
                                : theatre.images[index - 1]),
                          ),
                          border: Border.all(
                            width: 3,
                            color: state is ImageContainerSelectedState &&
                                    state.index == index
                                ? Colors.indigo
                                : white,
                          ),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    ),
  );
}
