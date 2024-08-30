import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'rag.dart';
import 'shortcuts.dart';

// 앱의 시작점
void main() {
  runApp(const MyApp());
}

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.blueGrey[800],
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[900],
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.grey[800],
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    hintStyle: TextStyle(color: Colors.grey[400]),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.grey[300]),
  ),
);

// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '맥 파워포인트 단축키',
      theme: darkTheme,
      home: const MyHomePage(title: '맥 파워포인트 단축키'),
    );
  }
}

// 앱의 홈 페이지 위젯
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  late Future<RAGSystem> _ragSystemFuture;
  List<Shortcut> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _ragSystemFuture = RAGSystem.create(sampleShortcuts);
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    final ragSystem = await _ragSystemFuture;
    final results = await ragSystem.search(query);
    setState(() {
      _searchResults = results;
    });

    developer.log('Search results for "$query":');
    for (var shortcut in _searchResults) {
      developer.log(shortcut.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<RAGSystem>(
        future: _ragSystemFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: '단축키 또는 동작 입력',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                    ),
                    onChanged: (query) => _performSearch(query),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _searchResults.isEmpty
                              ? Center(
                                  child: Text(
                                  _controller.text.isEmpty
                                      ? '검색어를 입력해주세요.'
                                      : '검색 결과가 없습니다.',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[400]),
                                ))
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: ListView.builder(
                                        itemCount: _searchResults.length,
                                        itemBuilder: (context, index) {
                                          final shortcut =
                                              _searchResults[index];
                                          return ListTile(
                                            title: Text(shortcut.keys,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                            subtitle: Text(shortcut.category,
                                                style: TextStyle(
                                                    color: Colors.grey[400],
                                                    fontSize: 12)),
                                            onTap: () {
                                              setState(() {
                                                _selectedShortcut = shortcut;
                                              });
                                            },
                                            selected:
                                                _selectedShortcut == shortcut,
                                            selectedTileColor:
                                                Colors.blueGrey[700],
                                          );
                                        },
                                      ),
                                    ),
                                    VerticalDivider(
                                        color: Colors.grey[700], width: 1),
                                    Expanded(
                                      flex: 1,
                                      child: _selectedShortcut != null
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(_selectedShortcut!.keys,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                  SizedBox(height: 8),
                                                  Text(
                                                      _selectedShortcut!
                                                          .category,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors
                                                              .grey[400])),
                                                  SizedBox(height: 16),
                                                  Text(
                                                      _selectedShortcut!
                                                          .description,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors
                                                              .grey[300])),
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: Text('단축키를 선택해주세요.',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.grey[400])),
                                            ),
                                    ),
                                  ],
                                ),
                        ),
                        // Check the location of vector store file
                        // const VerticalDivider(color: Colors.grey, width: 1),
                        // Expanded(
                        //   flex: 1,
                        //   child:
                        //       VectorStoreInfoWidget(ragSystem: snapshot.data!),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Shortcut? _selectedShortcut;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class VectorStoreInfoWidget extends StatelessWidget {
  final RAGSystem ragSystem;

  const VectorStoreInfoWidget({Key? key, required this.ragSystem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('벡터 저장소 정보', style: Theme.of(context).textTheme.titleLarge),
        FutureBuilder<String>(
          future: ragSystem.getVectorStoreFilePath(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                '파일 경로: ${snapshot.data}',
                style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                softWrap: true,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => ragSystem.openVectorStoreFileLocation(),
          child: Text('파일 위치 열기'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[700],
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
