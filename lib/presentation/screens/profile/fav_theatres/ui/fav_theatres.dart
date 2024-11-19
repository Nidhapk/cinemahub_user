import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/theatre/widget/theatre_container.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class FavTheatres extends StatelessWidget {
  const FavTheatres({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavTheatreBlocInFav>().add(
          FetchFavTheatresInFavEvent(FirebaseAuth.instance.currentUser!.uid),
        );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 22, 22, 47),
          foregroundColor: white,
          title: const Text('Favourite Theatres'),
        ),
        body: BlocBuilder<FavTheatreBlocInFav, FavTheatresInFavState>(
            builder: (context, state) {
          if (state is FavTheatreInitialStateInfav) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FavTheatreLaodedState) {
            final fav = state.theatreModel;
            if (fav.isEmpty) {
              return const Text('No favourites yet.');
            } else {
              return ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: fav.length,
                  itemBuilder: (context, index) {
                    return theatreContainer(
                        distance: '',
                        context: context,
                        theatre: fav[index],
                        onTap: () {},
                        favonTap: () {},
                        theatreId: fav[index].emailId);
                  });
            }
          } else if (state is FavTheatreLaodederrorState) {
            return Text(
              state.error,
            );
          } else {
            return const Text('something went wrong');
          }
        }));
  }
}
