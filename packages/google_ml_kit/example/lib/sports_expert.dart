class SportsExpert {
  var image;
  var name;
  List<Posture>? postures;


  SportsExpert({
    this.image,
    this.name,
    this.postures,
  });

  factory SportsExpert.fromDs(dynamic data) {
    return SportsExpert(
      image: data.data()['story'] ?? '',
      name: data.data()['story'] ?? '',
      postures: data.data()['story'] ?? [],
    );
  }

  factory SportsExpert.nullSportsExpert() {
    return SportsExpert(
      image: 'this is image',
      name: 'Squat',
    );
  }
}

class Posture {
  var posture;
  var postureComment;
  var posetureImage;

  Posture({
    this.posture,
    this.postureComment,
    this.posetureImage
  });

  factory Posture.fromDs(dynamic data) {
    return Posture(
      posture: data.data()['story'] ?? [],
      posetureImage: data.data()['story'] ?? [],
      postureComment: data.data()['story'] ?? [],
    );
  }
}