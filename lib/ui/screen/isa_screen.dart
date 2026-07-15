import 'package:finbrain/ui/screen/isa_guide_screen.dart';
import 'package:finbrain/ui/viewModel/shared_preferences_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_base_screen.dart';
import 'package:finbrain/ui/screen/isa_mp_screen.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/showing_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaScreen extends ConsumerStatefulWidget {
  const IsaScreen({super.key});

  @override
  ConsumerState<IsaScreen> createState() => _IsaScreenState();
}

class _IsaScreenState extends ConsumerState<IsaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        switch (_controller.index) {
          case 0:
            ref
                .read(isaJoinStatusViewModelProvider.notifier)
                .fetchIsaJoinStatus("1");
            break;
          case 1:
            ref
                .read(isaManagementStatusViewModelProvider.notifier)
                .fetchIsaManagementStatus("1");
            break;
          default:
            ref.read(fetchProductViewmodelProvider(ProductCategory.isaMp, "1"));
        }
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(isaJoinStatusViewModelProvider.notifier).fetchIsaJoinStatus("1");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isFirstRun = ref.watch(sharedPreferencesViewmodelProvider);
    ref.listen<bool>(
      sharedPreferencesViewmodelProvider.select((async) => async.requireValue),
      (prev, next) {
        if (next == true) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => const IsaGuideScreen()));
        }
      },
    );

    return isFirstRun.when(
      data: (data) {
        if (data) {
          return Scaffold(backgroundColor: colorScheme.primary);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref
                .read(isaJoinStatusViewModelProvider.notifier)
                .fetchIsaJoinStatus("1");
          });

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.zero,
                  color: colorScheme.tertiary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  elevation: 0,
                  child: TabBar(
                    controller: _controller,
                    padding: EdgeInsets.zero,
                    labelStyle: textTheme.titleMedium!.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    unselectedLabelStyle: textTheme.bodyMedium!.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: colorScheme.surfaceContainerHigh,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("가입 현황"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("운용 현황"),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text("MP 수익률"),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      const IsaBaseScreen(category: ProductCategory.isaJoin),
                      const IsaBaseScreen(
                        category: ProductCategory.isaManagement,
                      ),
                      const IsaMpScreen(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
      error: (error, stack) => const ShowingErrorWidget(),
      loading: () => const CustomProgressIndicator(),
    );
  }
}
