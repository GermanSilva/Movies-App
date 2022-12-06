// To parse this JSON data, do
//
//     final searchMovieResponse = searchMovieResponseFromMap(jsonString);

import 'dart:convert';

import 'package:movies_app/models/models.dart';

class SearchMovieResponse {
  SearchMovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory SearchMovieResponse.fromJson(String str) =>
      SearchMovieResponse.fromMap(json.decode(str));

  factory SearchMovieResponse.fromMap(Map<String, dynamic> json) =>
      SearchMovieResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
