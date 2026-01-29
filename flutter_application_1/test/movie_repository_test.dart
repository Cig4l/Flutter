import 'package:flutter_application_1/data/api/repository_implementation/MovieRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void main() {
  final movieApiMock = MovieApiMock();
  test('getMovies should return a list of movies', () async {
    when(() => movieApiMock.getMovies()).thenAnswer((_) async => [{
        'title': 'Star Wars', 
        'release_date': '13/12/1984',
        'director': 'George Lucas', 
        'opening_crawl': 'blablabla'
    }]);

    final movieRepository = MovieRepository(movieApi: movieApiMock);
    final movies = await movieRepository.getMovies();

    expect(movies.length, 1);
    expect(movies.first.title, 'Star Wars');
  });
}
