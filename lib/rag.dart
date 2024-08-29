import 'dart:math';

// RAG (Retrieval-Augmented Generation) 시스템을 구현한 클래스
class RAGSystem {
  final List<Shortcut> shortcuts;
  final double similarityThreshold = 0.2;

  RAGSystem(this.shortcuts);

  // 주어진 쿼리에 대해 관련된 단축키를 검색하는 메서드
  List<Shortcut> search(String query) {
    // 쿼리를 소문자로 변환
    query = query.toLowerCase();

    // 모든 단축키에 대해 유사도를 계산
    List<Shortcut> results = shortcuts.map((shortcut) {
      double similarity =
          _cosineSimilarity(query, shortcut.description.toLowerCase());
      return Shortcut(shortcut.keys, shortcut.description, similarity);
    }).toList();

    results = results
        .where((shortcut) => shortcut.similarity >= similarityThreshold)
        .toList();

    // 유사도에 따라 결과를 정렬 (내림차순)
    results.sort((a, b) => b.similarity.compareTo(a.similarity));

    // 상위 5개 결과만 반환
    return results.take(5).toList();
  }

  // 코사인 유사도를 계산하는 메서드
  double _cosineSimilarity(String s1, String s2) {
    // 각 문자열을 단어 집합으로 변환
    Set<String> words1 = s1.split(' ').toSet();
    Set<String> words2 = s2.split(' ').toSet();

    // 두 집합의 합집합 생성
    Set<String> union = words1.union(words2);

    int dotProduct = 0;
    int magnitude1 = 0;
    int magnitude2 = 0;

    // 각 단어에 대해 벡터 연산 수행
    for (String word in union) {
      int count1 = words1.contains(word) ? 1 : 0;
      int count2 = words2.contains(word) ? 1 : 0;
      dotProduct += count1 * count2;
      magnitude1 += count1 * count1;
      magnitude2 += count2 * count2;
    }

    // 코사인 유사도 계산 및 반환
    return dotProduct / (sqrt(magnitude1) * sqrt(magnitude2));
  }
}

// 단축키 정보를 저장하는 클래스
class Shortcut {
  final String keys; // 단축키 조합 (예: "⌘ + C")
  final String description; // 단축키 설명
  final double similarity; // 검색 쿼리와의 유사도 (검색 결과 정렬에 사용)

  Shortcut(this.keys, this.description, [this.similarity = 0.0]);

  @override
  String toString() {
    return 'Shortcut(keys: $keys, description: $description, similarity: ${similarity.toStringAsFixed(4)})';
  }
}
