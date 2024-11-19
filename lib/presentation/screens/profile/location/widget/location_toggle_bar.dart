import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/profile/location/widget/location.dart';
import 'package:userside/presentation/themes/app_colors.dart';

Widget locationToggleBar({required BuildContext context}) {
  context.read<LocationBloc>().add(const CheckLocationStatus());
  return locationBar(
      context: context,
      icon: BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
        return IconButton(
            onPressed: () {
              context.read<LocationBloc>().add(const ToggleLocation());
            },
            icon: Icon(
              state is LocationEnabled ? Icons.toggle_on : Icons.toggle_off,
              color: state is LocationEnabled
                  ? primaryColor
                  : const Color.fromARGB(255, 65, 65, 65),
              size: 36.0,
            ));
      }));
}
