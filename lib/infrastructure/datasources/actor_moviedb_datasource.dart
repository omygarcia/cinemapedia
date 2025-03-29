import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'language': 'es-MX',
        'api_key': Environment.theMovieDbKey,
      },
    ),
  );

  @override
  Future<List<Actor>> getActorByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    final creditResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors =
        creditResponse.cast.map((cast) {
          return ActorMapper.castToEntity(cast);
        }).toList();

    return actors;
  }
}
