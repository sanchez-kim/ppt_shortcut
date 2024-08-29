import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'rag.dart';
import 'shortcuts.dart';

// 앱의 시작점
void main() {
  runApp(const MyApp());
}

// 앱의 루트 위젯
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '맥 파워포인트 단축키',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '맥 파워포인트 단축키'),
    );
  }
}

// 앱의 홈 페이지 위젯
class MyHomePage extends StatefulWidget {
  // StatefulWidget는 변경 가능한 상태를 가진 위젯
  // 검색 결과와 같이 동적으로 변하는 데이터를 다룰때 사용
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 홈 페이지의 상태를 관리하는 클래스
class _MyHomePageState extends State<MyHomePage> {
  // 텍스트 입력을 관리하는 컨트롤러
  final TextEditingController _controller = TextEditingController();

  // RAG 시스템 인스턴스 생성 (sampleShortcuts은 미리 정의된 단축키 리스트)
  final RAGSystem _ragSystem = RAGSystem(sampleShortcuts);

  // 검색 결과를 저장하는 리스트
  List<Shortcut> _searchResults = [];

  // 검색을 수행하는 메서드
  void _performSearch(String query) {
    setState(() {
      // 쿼리가 비어있으면 빈 리스트를, 그렇지 않으면 검색 결과를 반환
      _searchResults = query.isEmpty ? [] : _ragSystem.search(query);

      // 콘솔에 검색 결과와 유사도 출력
      developer.log('Search results for "$query":');
      for (var shortcut in _searchResults) {
        developer.log(shortcut.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 검색 입력 필드
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: '단축키 또는 동작 입력',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              // 텍스트가 변경될 때마다 검색 수행
              onChanged: _performSearch,
            ),
            const SizedBox(height: 20),
            // 검색 결과 표시 영역
            Expanded(
              child: _searchResults.isEmpty
                  // 검색 결과가 없을 때 표시할 위젯
                  ? Center(
                      child: Text(
                      _controller.text.isEmpty
                          ? '검색어를 입력해주세요.'
                          : '검색 결과가 없습니다.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ))
                  // 검색 결과가 있을 때 리스트뷰로 표시
                  : ListView.builder(
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final shortcut = _searchResults[index];
                        return ListTile(
                          title: Text(shortcut.keys,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(shortcut.description),
                          onTap: () {
                            // TODO: 단축키 실행 기능 구현
                            print('Executing shortcut: ${shortcut.keys}');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 위젯이 제거될 때 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }
}
