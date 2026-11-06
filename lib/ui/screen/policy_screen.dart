import 'package:finbrain/ui/screen/main_screen.dart';
import 'package:finbrain/ui/viewModel/text_theme_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/onboarding_screen_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/privacy_policy_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_appbar.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/markdown_text_render.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolicyScreen extends ConsumerWidget {
  final bool isAgreed;
  final User? user;
  const PolicyScreen({super.key, required this.isAgreed, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = ref.watch(textThemeViewmodelProvider);

    final policy = ref.watch(privacyPolicyViewmodelProvider);
    bool isChecked = false;

    return Scaffold(
      backgroundColor: colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppbar(screen: "policy", title: "개인정보 처리방침"),
      ),
      body: policy.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  MarkdownTextRenderer(str: data),
                  if (!isAgreed) ...[
                    const SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () async {
                        isChecked = true;
                        await ref
                            .read(onboardingScreenViewmodelProvider(user).notifier)
                            .saveEmailAndDisplayName(user);
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => const MainScreen()),
                        );
                      },
                      icon: Icon(
                        (isChecked)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: colorScheme.onPrimary,
                        size: 32,
                      ),
                      label: Text(
                        "개인정보 처리방침에 동의합니다",
                        style: textTheme.titleLarge!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        loading: () => const CustomProgressIndicator(),
        error: (error, stackTrace) => const ShowingErrorWidget(),
      ),
    );
  }
}
