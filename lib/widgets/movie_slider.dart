import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/theme/app_theme.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
  final String? title;
  final List<Movie> movies;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    this.title,
    required this.movies,
    required this.onNextPage,
  }) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  bool generateNextPage = true;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // print('${scrollController.position.pixels}');
      // print('${scrollController.position.maxScrollExtent}');
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        if (generateNextPage) {
          widget.onNextPage();
          generateNextPage = false;
        }
      } else {
        generateNextPage = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.title!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          widget.movies.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movies.length,
                    itemBuilder: (_, int index) =>
                        _MoviePoster(movie: widget.movies[index]),
                  ),
                )
              : const SizedBox(
                  height: 190,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: AppTheme.primary,
                  )),
                ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movie.heroId = '${Random().nextInt(100)}-${movie.id}';
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              '/details',
              arguments: movie,
            ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 170,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
