import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/controller/ui/MovieScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Paradise',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MovieScreen(),
    );
  }
}


// import 'dart:async';
// import 'dart:convert';


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;


// Future<Film> fetchFilm() async {
//   final response = await http.get(
//     Uri.parse('https://swapi.info/api/films/1'),
//   );


//   if (response.statusCode == 200) {
//     return Film.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//   } else {
//     throw Exception('Failed to load Film');
//   }
// }


// class Film {
//   final String title;
//   final String director;
//   final int episodeId;


//   const Film({required this.title, required this.director, required this.episodeId});


//   factory Film.fromJson(Map<String, dynamic> json) {
//     return switch (json) {
//       {'title': String title, 'director': String director, 'episode_id': int episodeId, } => Film(
//         title: title,
//         director: director,
//         episodeId: episodeId,
//       ),
//       _ => throw const FormatException('Failed to load Film.'),
//     };
//   }
// }


// void main() => runApp(const MyApp());


// class MyApp extends StatefulWidget {
//   const MyApp({super.key});


//   @override
//   State<MyApp> createState() => _MyAppState();
// }


// class _MyAppState extends State<MyApp> {
//   late Future<Film> futureFilm;


//   @override
//   void initState() {
//     super.initState();
//     futureFilm = fetchFilm();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Star Wars Paradise',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Star Wars Paradise')),
//         body: Center(
//           child: FutureBuilder<Film>(
//             future: futureFilm,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }


//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }


// }
