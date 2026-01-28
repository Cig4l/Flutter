class Film {
  final String title;
  final String releaseDate;
  final String director;
  final String description;

  const Film({
    required this.title,
    required this.releaseDate,
    required this.director,
    required this.description
  });

    factory Film.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'title': String title, 
        'release_date': String releaseDate,
        'director': String director, 
        'opening_crawl': String description} => Film(
        title: title,
        releaseDate: releaseDate,
        director: director,
        description: description,
      ),
      _ => throw const FormatException('Model : failed to load films.'),
    };
  }
}