import 'package:flutter/material.dart';
import 'package:ghibliparser/api.dart';

import 'film.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Ghibli\'s films',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  List<Film> _films = List();
  bool _isFetching = false;
  String _error;

  @override
  void initState() {
    super.initState();
    loadFilms();
  }

  void loadFilms() async {
    setState(() {
      _isFetching = true;
      _error = null;
    });

    final films = await Api.getFilmsList();
    setState(() {
      _isFetching = false;
      if (films != null) {
        this._films = films;
      } else {
        _error = 'Error fetching films';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    if (_isFetching) {
      return Container(
          alignment: Alignment.center, child: Icon(Icons.timelapse));
    } else if (_error != null) {
      return Container(alignment: Alignment.center, child: Text(_error));
    } else {
      return ListView.builder(
          itemCount: _films.length,
          itemBuilder: (BuildContext context, i) {
            return ListTile(
                leading: Image(
                  image:AssetImage('assets/' + _films[i].title.toLowerCase().replaceAll(' ', '_').replaceAll('\'', '') + '.jpg'),
                ),
                title: Text(_films[i].title),
              subtitle: Text(_films[i].release_date),
            );
          });
    }
  }
}
