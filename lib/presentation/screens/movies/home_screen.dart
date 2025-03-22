import 'package:cinemapedia/presentation/providers/movies/initial_loading_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return FullScreenLoader();

    //if (nowPlayingMovies.isEmpty) return CircularProgressIndicator();
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
            titlePadding: EdgeInsets.all(0),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                //CustomAppbar(),
                MoviesSlideshow(movies: moviesSlideshow),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subtitle: '20 de Mayo',
                  loadNextPage: () {
                    //print('Llamado del padre');
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Proximamanete',
                  subtitle: 'En este mes',
                  loadNextPage: () {
                    //print('Llamado del padre');
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  //subtitle: 'En este mes',
                  loadNextPage: () {
                    //print('Llamado del padre');
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subtitle: 'De todos los años',
                  loadNextPage: () {
                    //print('Llamado del padre');
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),
                const SizedBox(height: 10),
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}

/*
      Column(
        children: [
          CustomAppbar(),
          MoviesSlideshow(movies: moviesSlideshow),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'En cines',
            subtitle: '20 de Mayo',
            loadNextPage: () {
              //print('Llamado del padre');
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Proximamanete',
            subtitle: 'En este mes',
            loadNextPage: () {
              //print('Llamado del padre');
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Populares',
            //subtitle: 'En este mes',
            loadNextPage: () {
              //print('Llamado del padre');
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Mejor calificadas',
            subtitle: 'De todos los años',
            loadNextPage: () {
              //print('Llamado del padre');
              ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
            },
          ),
          const SizedBox(height: 10),
          /*Expanded(
            child: ListView.builder(
              itemCount: nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final movie = nowPlayingMovies[index];
                return Material(child: ListTile(title: Text(movie.title)));
              },
            ),
          ),*/
        ],
      ),

 */
