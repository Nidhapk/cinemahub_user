import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:userside/data/model/movie/theatre_model.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_state.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/ui/shows_in_theatre.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_event.dart';
import 'package:userside/presentation/screens/theatre/widget/theatre_container.dart';
import 'package:userside/presentation/themes/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TheatreModel? theatre;
bool isFav = false;
LatLng? userLocation;
LatLng? tappedMarkerLocation;
double? distance;

class _SearchScreenState extends State<SearchScreen> {
  TileLayer get openStreetMapTileLater => TileLayer(
        urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<TheatreBloc>().add(
          const FetchAllTheatresTheatreEvent(),
        );
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    userLocation = await getUserLocation();
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<TheatreModel> cachedTheatres = [];
    List<TheatreModel> filteredTheatres = [];
    return Scaffold(
      body: BlocBuilder<TheatreBloc, TheatreState>(
        // buildWhen: (previous, current) =>
        //     (current is TheatresLoadedState && current is TheatreSelectedState),
        builder: (context, state) {
          List<Marker> markers = [];

          if (state is TheatreSelectedState) {
            theatre = state.theatre;
            distance = state.distance;
            log('dis:$distance');
          }
          if (state is TheatresFilteredState) {
            filteredTheatres = state.filteredTheatres;
            log('filll $filteredTheatres');
          }
          if (state is TheatresLoadedState) {
            cachedTheatres = state.theatres;
            log('${state.theatres}');
            for (TheatreModel i in state.theatres) {
              markers.add(
                Marker(
                  point: i.latLng,
                  child: GestureDetector(
                    onTap: () {
                      context.read<TheatreBloc>().add(
                            SelectTheatreEvent(i, userLocation!),
                          );
                      //  _onMarkerTapped(i.latLng);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: filteredTheatres.contains(i)
                                ? primaryColor
                                : Colors.grey),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(i.profileImage),
                        child: i.profileImage.isEmpty
                            ? const Icon(Icons.theater_comedy,
                                color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          if (state is TheatreSelectedState || state is TheatresFilteredState) {
            for (TheatreModel theatre in cachedTheatres) {
              markers.add(
                Marker(
                  point: theatre.latLng,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<TheatreBloc>()
                          .add(SelectTheatreEvent(theatre, userLocation!));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          filteredTheatres.contains(theatre)
                              ? BoxShadow(
                                  color: primaryColor.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 10)
                              : const BoxShadow(color: Colors.transparent)
                        ],
                        shape: BoxShape.circle,
                        border: Border.all(
                            width: filteredTheatres.contains(theatre) ? 3 : 1,
                            color: filteredTheatres.contains(theatre)
                                ? primaryColor
                                : Colors.grey),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(theatre.profileImage),
                        child: theatre.profileImage.isEmpty
                            ? const Icon(Icons.theater_comedy,
                                color: Colors.white)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }
          }
          return Stack(
            children: [
              FlutterMap(
                  options: MapOptions(
                      minZoom: 3,
                      maxZoom: 18,
                      initialCenter: const LatLng(10.8505, 76.2711),
                      initialZoom: 11,
                      interactionOptions:
                          const InteractionOptions(flags: InteractiveFlag.all),
                      onTap: (tapPosition, point) {}),
                  children: [
                    openStreetMapTileLater,
                    MarkerLayer(
                      markers: markers,
                    ),
                  ]),
              Padding(
                padding: EdgeInsets.only(
                    top: height * 0.07,
                    left: width * 0.05,
                    right: width * 0.05),
                child: SearchBar(
                  controller: _searchController,
                  onChanged: (query) {
                    // Trigger your search event in the Bloc
                    context.read<TheatreBloc>().add(SearchTheatresEvent(query));
                  },
                  leading: Icon(
                    Icons.location_on_rounded,
                    color: primaryColor,
                    size: 17,
                  ),
                  hintStyle: WidgetStateProperty.all(
                    const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  ),
                  hintText: 'Search by cinema or place',
                  shadowColor: WidgetStatePropertyAll(
                    Colors.grey.withOpacity(0.5),
                  ),
                  elevation: const WidgetStatePropertyAll(5),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                ),
              ),
              BlocBuilder<TheatreBloc, TheatreState>(builder: (context, state) {
                if (state is TheatreSelectedState) {
                  return theatreContainer(
                      distance:
                          '${distance.toString()} Km from your current location',
                      theatreId: state.theatre.emailId,
                      favonTap: () {
                        context.read<FavTheatreBloc>().add(
                            ToggleFavoriteEventInTheatre(
                                theatreId: state.theatre.emailId,
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                isFavorite: !isFav));
                      },
                      context: context,
                      theatre: theatre!,
                      onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowsInTheatresScreen(
                                theatre: theatre!,
                                email: state.theatre.emailId,
                              ),
                            ),
                          ));
                } else {
                  return const SizedBox.shrink();
                }
              })
            ],
          );
        },
      ),
    );
  }
}

Future<LatLng?> getUserLocation() async {
  final location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) return null;
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) return null;
  }

  final userLocation = await location.getLocation();
  return LatLng(userLocation.latitude!, userLocation.longitude!);
}
