class ReviewAnalysis {
  final String word;
  final int count;
  Map<String, dynamic>? mapData;

  ReviewAnalysis({
    required this.word,
    required this.count,
  }){
    mapData = {'word' : word, 'count' : count};
  }

  factory ReviewAnalysis.fromJson(Map<String, dynamic> json) {
    return ReviewAnalysis(
      word: json['word'],
      count: json['count'],
    );
  }
}

