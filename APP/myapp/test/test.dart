import 'package:flutter/material.dart'; //Scaffold 위젯을 사용하기 위해 필요
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class RandomWords extends StatefulWidget //State 클래스 생성하는 위젯
{
    _RandomWordsState createState() => _RandomWordsState(); //식별자 앞에 _를 붙이면 개인정보 보호(private)
}
class _RansomWordsState extends State<RandomWords>
{
    final _suggestions = <WordPair>[];
    final _saved = <WordPair>{}; //set( {} )은 List( [] )와 다르게 중복 항목을 허용하지 않음
    final _biggerFont = const TextStyle(fontSize: 18);
    Widget build(BuildContext context)
    {
        return Scaffold(
            appBar: AppBar(
                title: Text('Startup Name Generator'),
            ),
            body: _buildSuggestions(),
        );
    }
    Widget _buildSuggestions()
    {
        return Listview.builder(
            padding: const EdgeInsets.all(16), //모든 외부 면(padding)에 16픽셀 여백
            itemBuilder: (BuildContext _context, int i)
            {
                if(i.isOdd)
                {
                    return Divider(); //이터레이터 i가 홀수면 구분선 위젯(Divider)을 만듦
                }
                final int index = i ~/ 2; //i를 2로 나눈 몫을 index에 저장
                if(index >= _suggestions.length)
                {
                    _suggestions.addAll(generateWordPairs().take(10)); //10개씩 새로 만들기
                }
                return _buildRow(_suggestions[index]);
            }
        );
    }
    Widget _buildRow(WordPair pair) //줄마다 하나의 단어쌍이 보이도록 하는 위젯
    {
        final alreadySaved = _saved.contains(pair); //단어쌍이 이미 즐겨찾기(alreadySaved)에 저장되어 있는지 확인
        return ListTile(
            title: Text(
                pair.asPascalCase,
                style: _biggerfont,
            ),
            trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
            ),
            onTap: ()
            {
                setState(() {
                    if(alreadySaved)
                    {
                        _saved.remove(pair);
                    }
                    else
                    {
                        _saved.add(pair);
                    }
                });
            },
        );
    }
}
class MyApp extends StatelessWidget
{
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Startup Name Generator', 
            home: RandomWords(),
        );
    }
}