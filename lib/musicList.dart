import 'package:flutter/material.dart';
import 'main.dart';

// var song = {"Beautiful In White", "Happy Together"};
// var singer = {"Westlife", "The Turtles"};

class MusicList extends StatefulWidget {
  MusicList({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  @override
  void initState() {
    super.initState();
    // getMusicList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF090e42),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            searchBar(),
            SizedBox(height: 20.0),
            musicList(),
          ],
        ),
      ),
    );
  }

  Widget searchBar(){
    return Container(
      height: 40.0,
      color: Colors.grey.withOpacity(0.16),
      child: Row(
        children: <Widget>[
// Search Icon
          SizedBox(width: 5.0),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
//-----------------------------------------------------------
          SizedBox(width: 5.0),
// Text Input Field
          Expanded(
            child: TextField(
              onChanged: (String str){
                print(str);
              },
              decoration: InputDecoration(
                hintText: 'Filter song...',
                hintStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.75,
                ),
              border: InputBorder.none,
              ),
            showCursor: true,
            cursorColor: Colors.black,
            )
          )
//-----------------------------------------------------------
        ],
      ),
    );
  }
  Widget musicList(){
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index){                      
          return ListTile(
              leading: Icon(
                Icons.music_note,
                color: Colors.white,
                size: 40.0,
              ),
              title: Text(
                "Song $index",
                // musicLst[index]['Song'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Singer $index",
                // musicLst[index]['Singer'],
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.more_vert,
                color: Colors.white,
                size: 30.0,
              ),
              onTap: () {
                Music.song = "Song $index"; // musicLst[index]['Song'];
                Music.singer = "Singer $index"; // musicLst[index]['Singer'];
                Navigator.pushNamed(context, '/musicplayer');
              },
            );
          },
        itemCount: 5 // musicLst.length
      )
    );
  }

}