import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userside/data/services/movies_repository.dart';
import 'package:userside/firebase_options.dart';
import 'package:userside/presentation/bloc/calendar/bloc_bloc.dart';
import 'package:userside/presentation/bloc/foregetPassword/bloc_bloc.dart';
import 'package:userside/presentation/bloc/splash_bloc.dart/bloc_bloc.dart';
import 'package:userside/presentation/bloc/userAuth_bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/booking/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/banner/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/coming_soon_widget/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/home/widgets/now_showing/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/main_screen.dart';
import 'package:userside/presentation/screens/movie/movie_details/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_rating/add_movie_rating/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/movie_rating/edit_movie_rating/ui/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/movie/showing_theatres/widgets/filter/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/fav_theatres/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/location/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/my_bookings/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/profile/ticket/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/search/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/shows_in_theatre/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/theatre_details/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/theatre/widget/fav_bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/user_auth/forgetpassword.dart';
import 'package:userside/presentation/screens/user_auth/signin_screen.dart';
import 'package:userside/presentation/screens/user_auth/signup/bloc/bloc_bloc.dart';
import 'package:userside/presentation/screens/user_auth/signup/signup_screen.dart';
import 'package:userside/presentation/screens/splash/splash_screen.dart';
import 'package:userside/presentation/themes/app_colors.dart';
import 'package:userside/presentation/themes/app_textstyles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashscreenBloc(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => CalendarBloc(),
        ),
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
        BlocProvider(
          create: (context) => MovieDetailsBloc(
            movieRepository: MoviesRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => NowShowingBloc(),
        ),
        BlocProvider(
          create: (context) => ShowFilterBloc(),
        ),
        BlocProvider(
          create: (context) => BannerBloc(),
        ),
        BlocProvider(
          create: (context) => BookingBloc(),
        ),
        BlocProvider(
          create: (context) => MovieRatingReviewBloc(),
        ),
        BlocProvider(
          create: (context) => EditMovieRatingReviewBloc(),
        ),
        BlocProvider(
          create: (context) => TicketBloc(),
        ),
        BlocProvider(
          create: (context) => ComingSoonMovieBloc(),
        ),
        BlocProvider(
          create: (context) => TheatreBloc(),
        ),
        BlocProvider(
          create: (context) => FavTheatreBloc(),
        ),
        BlocProvider(
          create: (context) => FavTheatreBlocInFav(),
        ),
        BlocProvider(
          create: (context) => SearchMovieBloc(),
        ),
        BlocProvider(
          create: (context) => ShowsInTheatreBloc(),
        ),
        BlocProvider(
          create: (context) => NowShowingMovieBloc(),
        ),
        BlocProvider(
          create: (context) => MyBookingsBloc(),
        ),
        BlocProvider(create: (context) => TheatreDeatilsBloc()),
        BlocProvider(create: (context) => LocationBloc())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            headlineLarge: AppTextstyles.headlineLarge,
            headlineMedium: AppTextstyles.headlineMedium,
            headlineSmall: AppTextstyles.headlineSmall,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width * 0.92,
                    MediaQuery.of(context).size.height * 0.06),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: primaryColor,
                foregroundColor: white),
          ),
        ),
        routes: {
          '/signUp': (context) => SignUpScreen(),
          '/signIn': (context) => const LoginScreen(),
          '/splash': (context) => const SplashScreenContent(),
          // '/showingTheatres': (context) => const ShowingTheatresScreen(),
          //'/home': (context) =>  const HomeScreen(),
          '/forgetPass': (context) => const ForgetPassScreen(),
          '/main': (context) => const MainScreen(),

          //'/movieDetails': (context) => const MovieDetailsScreen()
        },
        home: //ViewTicketScreen()
            const SplashScreenContent(),
      ),
    );
  }
}
