class Film {
  final String id;
  final String title;
  final String description;
  final String director;
  final String producer;
  final String release_date;
  final String rt_score;

  Film(this.id, this.title, this.description, this.director, this.producer,
      this.release_date, this.rt_score);

  static List<Film> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList
        .map((r) => Film(r['id'], r['title'], r['description'], r['director'],
            r['producer'], r['release_date'], r['rt_score']))
        .toList();
  }
}
