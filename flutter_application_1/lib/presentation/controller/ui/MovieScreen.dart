import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/api/MovieApi.dart';
import 'package:flutter_application_1/data/api/repository_implementation/MovieRepository.dart';
import 'package:flutter_application_1/presentation/controller/MovieController.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerWidget {
  // final MovieController controller = MovieController(
  //   repository: MovieRepository(movieApi: MovieApi()),
  // );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(movieController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste de films Star Wars', style: TextStyle(color: Colors.white)), 
        backgroundColor: Colors.deepPurple,
      ),
      body: moviesAsync.when(
      data: (movies) {
        return ListView.builder(
          itemCount: movies.length,
                      itemBuilder: (context, index) {
              final movie = movies[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 5,
                  shadowColor: Colors.deepPurple.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateTime.parse(movie.releaseDate).toString(),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          movie.director,
                          style: const TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          child: Text(
                            movie.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
        );
      },
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}