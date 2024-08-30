// 단축키 클래스 정의
class Shortcut {
  final String keys; // 단축키 조합
  final String description; // 설명
  final String category; // 카테고리

  Shortcut(this.keys, this.description, this.category);

  // 단축키 조합을 리스트로 분리
  List<String> get keyCombination =>
      keys.split('+').map((key) => key.trim()).toList();
}

// 예제 단축키 데이터
final List<Shortcut> sampleShortcuts = [
  // 자주 사용하는 바로 가기
  Shortcut('⌘ + N', '새 프레젠테이션을 만듭니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Shift + N', '새 슬라이드를 추가합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + B', '선택한 텍스트에 굵게 서식을 적용합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + T', '글꼴 대화 상자를 엽니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + X', '선택한 텍스트, 개체 또는 슬라이드를 잘라냅니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + C', '선택한 텍스트, 개체 또는 슬라이드를 복사합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + V', '잘라내거나 복사한 텍스트, 개체 또는 슬라이드를 붙여넣습니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + K', '하이퍼링크를 삽입합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Shift + M', '메모를 삽입합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Z', '마지막 작업 실행을 취소합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Y', '마지막 작업을 다시 실행합니다.', '자주 사용하는 바로 가기'),
  Shortcut('Page Down', '다음 슬라이드로 이동합니다.', '자주 사용하는 바로 가기'),
  Shortcut('Page Up', '이전 슬라이드로 이동합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Shift + Return', '슬라이드 쇼를 시작합니다.', '자주 사용하는 바로 가기'),
  Shortcut('Esc', '슬라이드 쇼를 종료합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + P', '프레젠테이션을 인쇄합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + S', '프레젠테이션을 저장합니다.', '자주 사용하는 바로 가기'),
  Shortcut('⌘ + Q', 'PowerPoint를 닫습니다.', '자주 사용하는 바로 가기'),

  // 프레젠테이션 및 슬라이드 작업
  Shortcut('⌘ + Shift + P', 'PowerPoint 템플릿 갤러리의 템플릿으로 새 프리젠테이션을 만듭니다.',
      '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Shift + N', '새 슬라이드 삽입', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('Page Down', '다음 슬라이드로 이동합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('Page Up', '이전 슬라이드로 이동합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Shift + 2', '슬라이드 배경 서식을 지정합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + -', '축소합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + +', '확대합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Option + O', '크기에 맞게 확대/축소합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Shift + D', '선택한 슬라이드의 복사본을 만듭니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + O', '프레젠테이션을 엽니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + W', '프레젠테이션을 닫습니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + P', '프레젠테이션을 인쇄합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Shift + S', '다른 이름, 위치 또는 파일 형식으로 프레젠테이션을 저장합니다.',
      '프레젠테이션 및 슬라이드 작업'),
  Shortcut('Esc', '다른 이름으로 저장과 같은 명령을 취소합니다.', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + ~', '열려 있는 여러 프레젠테이션 사이 이동', '프레젠테이션 및 슬라이드 작업'),
  Shortcut('⌘ + Shift + O', '최근 파일을 엽니다.', '프레젠테이션 및 슬라이드 작업'),

  // 개체 및 텍스트 작업
  Shortcut('⌘ + X', '선택한 개체 또는 텍스트를 잘라냅니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + C', '선택한 개체 또는 텍스트를 복사합니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + V', '잘라내거나 복사한 개체 또는 텍스트를 붙여 넣습니다.', '개체 및 텍스트 작업'),
  Shortcut('Control + D', '선택한 개체가 중복되었습니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + Shift + C', '선택한 개체 또는 텍스트의 서식을 복사합니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + Shift + V', '복사한 서식을 선택한 개체 또는 텍스트에 붙여넣습니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + Option + Shift + C', '애니메이션을 복사합니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + Option + Shift + V', '애니메이션을 붙여넣습니다.', '개체 및 텍스트 작업'),
  Shortcut('⌘ + Control + V', '선택하여 붙여넣기 대화 상자를 엽니다.', '개체 및 텍스트 작업'),

  // 개체 선택 및 정렬
  Shortcut('Tab', '하나의 개체가 선택되면 다른 개체를 선택합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Option + Shift + B', '개체를 한 위치 뒤로 보냅니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Option + Shift + F', '개체를 한 위치 앞으로 보냅니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Shift + B', '개체를 맨 뒤로 보냅니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Shift + F', '개체를 맨 앞으로 보냅니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + A', '슬라이드의 모든 개체를 선택합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Option + G', '선택한 개체를 그룹화합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Option + Shift + G', '선택한 개체의 그룹 해제', '개체 선택 및 정렬'),
  Shortcut('⌘ + Option + J', '선택한 개체를 다시 그룹화합니다.', '개체 선택 및 정렬'),
  Shortcut('Option + →', '선택한 개체를 시계 방향으로 15도 회전합니다.', '개체 선택 및 정렬'),
  Shortcut('Option + ←', '선택한 개체를 시계 반대 방향으로 15도 회전합니다.', '개체 선택 및 정렬'),
  Shortcut('Space', '미디어를 재생하거나 일시 중지합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + K', '하이퍼링크를 삽입합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Shift + M', '메모를 삽입합니다.', '개체 선택 및 정렬'),
  Shortcut('⌘ + Shift + 1', '선택한 개체의 서식을 지정합니다.', '개체 선택 및 정렬'),
  Shortcut('Shift + ↑', '선택한 개체의 크기를 조정합니다.', '개체 선택 및 정렬'),
  Shortcut('→', '선택한 개체를 화살표 방향으로 이동합니다.', '개체 선택 및 정렬'),

  // 텍스트 선택
  Shortcut('⌘ + A', '모든 텍스트를 선택합니다.', '텍스트 선택'),
  Shortcut('⌘ + Shift + →', '현재 커서 위치에서 다음 단어로 텍스트를 확장합니다.', '텍스트 선택'),
  Shortcut('⌘ + Shift + ←', '현재 커서 위치에서 이전 단어로 텍스트를 확장합니다.', '텍스트 선택'),
  Shortcut('⌘ + Shift + ↓', '현재 커서 위치에서 다음 줄로 텍스트를 확장합니다.', '텍스트 선택'),
  Shortcut('⌘ + Shift + ↑', '현재 커서 위치에서 이전 줄로 텍스트를 확장합니다.', '텍스트 선택'),

  // 텍스트 서식 지정
  Shortcut('⌘ + T', '글꼴 대화 상자를 엽니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + B', '선택한 텍스트에 굵게 서식을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + I', '선택한 텍스트에 기울임꼴 서식을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + U', '선택한 텍스트에 밑줄 서식을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Shift + H', '선택한 텍스트에 숨겨진 서식을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Option + Control + G', '선택한 텍스트에 특수 서식을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Shift + L', '텍스트를 왼쪽 정렬합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Shift + E', '텍스트를 가운데 정렬합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Shift + R', '텍스트를 오른쪽 정렬합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Option + Shift + J', '텍스트를 양쪽 정렬합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Shift + P', '선택한 텍스트에 서식 있는 목록을 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Option + Shift + N', '선택한 텍스트에 번호 매기기를 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Option + Shift + B', '선택한 텍스트에 글머리표를 적용합니다.', '텍스트 서식 지정'),
  Shortcut('⌘ + Option + 0', '텍스트 간격을 설정합니다.', '텍스트 서식 지정'),
];
