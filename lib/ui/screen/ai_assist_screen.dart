import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/ui/widget/ai_request.dart';
import 'package:finbrain/ui/widget/ai_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AiAssistScreen extends StatelessWidget{
  AiAssistScreen({super.key});
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: primary100,
        title: const Text(
          "AI 어시스트",
          style: TextStyle(
            color: textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const AiSummary(),
                const AiSummary(),
                const AiRequest()
              ],
            ),
          ),
          Spacer(),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              color: primary100,
            ),
            child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: (value){},
                    decoration: const InputDecoration(
                      hintText: "AI한테 질문하기",
                      hintStyle: TextStyle(
                        color: textSecondary,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: SvgPicture.asset("assets/images/send_icon.svg", width: 42, height: 42,)
                )
              ],
            )
          )
          )
        ],
      )
    );
  }
}