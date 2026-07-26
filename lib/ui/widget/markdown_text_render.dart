import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 마크다운 텍스트 변환
class MarkdownTextRenderer extends StatelessWidget {
  final String str;         // AI 생성 텍스트(AI text)

  const MarkdownTextRenderer({super.key, required this.str});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        text: TextSpan(
          style: GoogleFonts.notoSansKr(
            fontSize: 16,
            color: colorScheme.onSecondary,
          ),
          children: _parseMarkdownToTextSpans(str, colorScheme.onSecondary),
        ),
      ),
    );
  }

  // 마크다운 스트링을 분석하여 TextSpan 리스트로 변환하는 핵심 함수
  // Anaylze markdown string and return as TextSpan list
  List<TextSpan> _parseMarkdownToTextSpans(String rawText, Color color) {
    List<TextSpan> spans = [];
    List<String> lines = rawText.split('\n');

    for (var line in lines) {
      // 1. 구분선 처리 (---)
      // 1. Dividing Line Processing
      if (line.trim() == '---') {
        spans.add(const TextSpan(
          text: '',
        ));
        continue;
      }

      // 2. 제목 처리 (#, ##, ###)
      // 2. Title Processing (#, ##, ###)
      if (line.startsWith('#')) {
        int hashCount = 0;
        while (hashCount < line.length && line[hashCount] == '#') {
          hashCount++;
        }
        String titleText = line.replaceAll("**", "").substring(hashCount).trim();
        
        double fontSize = 14;
        if (hashCount == 1) fontSize = 22;
        else if (hashCount == 2) fontSize = 20;
        else if (hashCount == 3) fontSize = 18;

        spans.add(TextSpan(
          text: '$titleText\n',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ));
        continue;
      }
      
      // 3. 일반 텍스트 라인 (내부 ** 굵게 처리 포함)
      // 3. Normal text line(Change text weight to bold)
      spans.add(_parseInlineStyles('$line\n', color));
    }

    return spans;
  }

  // 한 줄 내부에서 ** 텍스트를 찾아 bold 스타일을 먹이는 인라인 파서
  // Inline parser finding **text and change text weight to bold
  TextSpan _parseInlineStyles(String line, Color color) {
    List<TextSpan> inlineSpans = [];
    RegExp exp = RegExp(r'\*\*(.*?)\*\*', dotAll: true); // ** 텍스트 ** 찾는 정규식
    int start = 0;

    for (var match in exp.allMatches(line)) {
      // ** 앞부분 일반 텍스트 추가
      if (match.start > start) {
        inlineSpans.add(TextSpan(text: line.substring(start, match.start)));
      }
      // ** 내부 텍스트 굵게 추가
      inlineSpans.add(TextSpan(
        text: (match.group(1) ?? "").replaceAll(r'\n', ''),
        style: TextStyle(fontWeight: FontWeight.bold, color: color),
      ));
      start = match.end;
    }

    // 남은 뒷부분 텍스트 추가
    if (start < line.length) {
      inlineSpans.add(TextSpan(text: line.substring(start)));
    }

    return TextSpan(
      children: inlineSpans,
    );
  }
}