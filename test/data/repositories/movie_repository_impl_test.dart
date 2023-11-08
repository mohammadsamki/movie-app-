import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/domain/entities/Movie.dart';

import 'movie_repository_impl_test.mocks.dart';


@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])

void main(){
  late MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(
      remoteDataSource: mockMovieRemoteDataSource
    );
  });

  final tMovieModelList = [
    MovieModel(id: 1, title: "Test Movie 1", overview: "Desc 1", posterPath: "/image1"),
    MovieModel(id: 2, title: "Test Movie 2", overview: "Desc 2", posterPath: "/image2"),
  ];

  final tMoviesList = [
    Movie(id: 1, title: "Test Movie 1", overview: "Desc 1", posterPath: "/image1"),
    Movie(id: 2, title: "Test Movie 2", overview: "Desc 2", posterPath: "/image2"),
  ];

  final String tQuery = 'Inception';

  test('should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getTrendingMovies();

    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, equals(tMoviesList));
  });

  test('should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, equals(tMoviesList));
  });

  test('should search movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    final result = await repository.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, equals(tMoviesList));
  });

}

