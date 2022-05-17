class SportsExpert {
  var image;
  var name;
  var video;
  var video_comment;

  SportsExpert({
    this.image,
    this.name,
    this.video,
    this.video_comment,
  });

  factory SportsExpert.fromDs(dynamic data) {
    return SportsExpert(
      image: data.data()['story'] ?? '',
      name: data.data()['story'] ?? '',
      video: data.data()['story'] ?? [],
      video_comment: data.data()['story'] ?? [],
    );
  }

  factory SportsExpert.nullSportsExpert() {
    return SportsExpert(
      image: 'this is image',
      name: 'Squat',
      video: ['first video'],
      video_comment: ['first video']
    );
  }
}