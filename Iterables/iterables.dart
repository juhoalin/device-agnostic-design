main() {
  List<int> numbers = [1, 2, 3, -4, -5, -6];
  print(sumOfNegatives(numbers)); // -15

  List<int> numbers2 = [-1, -2, -3, -4, -5, -6];
  print(averageOfPositives(numbers2)); // 3.5

  final hjk = Team('HJK', 'Helsinki', 1907);
  print(hjk); // HJK(Helsinki, year: 1907)
  final secret = Team.nameAndYear("Secret", 1984);
  print(secret); // Secret(Unknown, year: 1984

  final playlist = Playlist();
  playlist.add(Video(name: 'Video 1', duration: 120));
  playlist.add(Video(name: 'Video 2', duration: 240));
  playlist.add(Video(name: 'Video 3', duration: 180));
  print(playlist.has('Video 2')); // true
  print(playlist.duration()); // 540
}

sumOfNegatives(List<int> numbers) {
  return numbers.where((number) => number < 0).reduce((a, b) => a + b);
}

double averageOfPositives(List<int> numbers) {
  var positives = numbers.where((number) => number > 0);
  return positives.length == 0
      ? -1
      : positives.reduce((a, b) => a + b) / positives.length;
}

class Team {
  String name;
  String homeTown;
  int year;

  Team(this.name, this.homeTown, this.year);
  Team.nameAndYear(this.name, this.year) : homeTown = 'Unknown';

  @override
  String toString() {
    return '$name ($homeTown, $year)';
  }
}

class Video {
  String name;
  int duration;

  

  Video({this.name = "unknown", this.duration = 0});


  @override
  String toString() {
    var durationString = this.duration > 1 ? 'seconds' : 'second';
    return '$name ($duration $durationString)';
  }
}

class Playlist {
  List<Video> videos = [];

  Playlist();

  void add(Video video) {
    videos.add(video);
  }

  bool has(String name) {
    return videos.any((video) => video.name == name);
  }

  int duration() {
    return videos.fold(0, (total, video) => total + video.duration);
  }

}