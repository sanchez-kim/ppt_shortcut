import 'package:langchain/langchain.dart';
import 'package:langchain_ollama/langchain_ollama.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'shortcuts.dart';

class RAGSystem {
  late final Embeddings embeddings;
  final List<
      ({
        String id,
        List<double> vector,
        Map<String, dynamic> metadata,
        String content
      })> vectorStore = [];
  final Uuid _uuid = const Uuid();
  static const String _fileName = 'vector_store.json';

  RAGSystem._();

  static Future<RAGSystem> create(List<Shortcut> shortcuts) async {
    final instance = RAGSystem._();
    await instance._initialize(shortcuts);
    return instance;
  }

  Future<void> _initialize(List<Shortcut> shortcuts) async {
    try {
      embeddings = OllamaEmbeddings(
        model: 'nomic-embed-text',
        baseUrl: 'http://127.0.0.1:11434/api',
      );

      final file = await _getFile();
      if (await file.exists()) {
        print('Loading existing vector store...');
        await _loadVectorStore(file);
      } else {
        print('Creating new vector store...');
        await _createVectorStore(shortcuts);
        await _saveVectorStore(file);
      }
    } catch (e, stackTrace) {
      print('Error initializing RAGSystem: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to initialize RAG system: $e');
    }
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> _loadVectorStore(File file) async {
    final content = await file.readAsString();
    final List<dynamic> jsonList = json.decode(content);
    vectorStore.clear();
    for (var item in jsonList) {
      vectorStore.add((
        id: item['id'],
        vector: (item['vector'] as List).cast<double>(),
        metadata: Map<String, dynamic>.from(item['metadata']),
        content: item['content'],
      ));
    }
  }

  Future<void> _createVectorStore(List<Shortcut> shortcuts) async {
    for (var shortcut in shortcuts) {
      final content = '${shortcut.keys}: ${shortcut.description}';
      final vector = await embeddings.embedQuery(content);
      vectorStore.add((
        id: _uuid.v4(),
        vector: vector,
        metadata: {'category': shortcut.category},
        content: content,
      ));
    }
  }

  Future<void> _saveVectorStore(File file) async {
    final jsonList = vectorStore
        .map((item) => {
              'id': item.id,
              'vector': item.vector,
              'metadata': item.metadata,
              'content': item.content,
            })
        .toList();
    await file.writeAsString(json.encode(jsonList));
  }

  Future<List<Shortcut>> search(String query) async {
    try {
      final queryVector = await embeddings.embedQuery(query);
      final results = _cosineSimilaritySearch(queryVector, 5);

      return results.map((result) {
        final parts = result.content.split(':');
        return Shortcut(
          parts[0].trim(),
          parts.sublist(1).join(':').trim(),
          result.metadata['category'] as String,
        );
      }).toList();
    } catch (e) {
      print('Error during search: $e');
      rethrow;
    }
  }

  List<
      ({
        String id,
        List<double> vector,
        Map<String, dynamic> metadata,
        String content
      })> _cosineSimilaritySearch(List<double> queryVector, int k) {
    final scores = vectorStore.map((item) {
      final similarity = _cosineSimilarity(queryVector, item.vector);
      return (item: item, score: similarity);
    }).toList();

    scores.sort((a, b) => b.score.compareTo(a.score));
    return scores.take(k).map((e) => e.item).toList();
  }

  double _cosineSimilarity(List<double> a, List<double> b) {
    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;
    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  // just for debugging
  Future<String> getVectorStoreFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  Future<void> openVectorStoreFileLocation() async {
    final path = await getVectorStoreFilePath();
    final file = File(path);
    if (await file.exists()) {
      // macOS에서 Finder로 파일 위치 열기
      await Process.run('open', ['-R', path]);
    } else {
      print('Vector store file does not exist yet.');
    }
  }
}

double sqrt(double x) => x <= 0 ? 0 : _sqrtNewtonRaphson(x, x, 0);

double _sqrtNewtonRaphson(double x, double curr, int depth) {
  if (depth > 10) return curr;
  double next = (curr + x / curr) / 2;
  if ((next - curr).abs() < 1e-9) return next;
  return _sqrtNewtonRaphson(x, next, depth + 1);
}
