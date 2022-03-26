String baseUel = 'https://newsapi.org';


void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';




//https://newsapi.org/v2/top-headlines?country=eg&apiKey=bc88c0d4da3c484fa28644e1698c1651

/*



https://newsapi.org/v2/everything?q=tesla&from=2022-02-06&sortBy=publishedAt&apiKey=bc88c0d4da3c484fa28644e1698c1651








*/
