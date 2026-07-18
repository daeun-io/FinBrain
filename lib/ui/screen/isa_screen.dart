import 'package:finbrain/ui/screen/isa_guide_screen.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/shared_preferences_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_base_screen.dart';
import 'package:finbrain/ui/screen/isa_mp_screen.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_progress_indicator.dart';
import 'package:finbrain/ui/widget/custom_tapbar.dart';
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
        final page = ref.read(
          currentPageViewmodelProvider(switch (_controller.index) {
            0 => ProductCategory.isaJoin,
            1 => ProductCategory.isaManagement,
            _ => ProductCategory.isaMp,
          }),
        );
        ref.read(switch (_controller.index) {
          0 => fetchIsaJoinStatusViewmodelProvider("$page"),
          1 => fetchIsaMngmStatusViewmodelProvider("$page"),
          _ => fetchProductViewmodelProvider(ProductCategory.isaMp, "$page"),
        });
      }
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

    final tabList = ["가입 현황", "운용 현황", "MP 수익률"];
    final tabView = const [
      IsaBaseScreen(category: ProductCategory.isaJoin),
      IsaBaseScreen(category: ProductCategory.isaManagement),
      IsaMpScreen(),
    ];

    return isFirstRun.when(
      data: (data) {
        if (data) {
          return Scaffold(backgroundColor: colorScheme.primary);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final page = ref.read(
              currentPageViewmodelProvider(ProductCategory.isaJoin),
            );
            ref.read(fetchIsaJoinStatusViewmodelProvider("$page"));
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
                  child: CustomTapbar(
                    tabList: tabList,
                    isIsaScreen: true,
                    controller: _controller,
                  ),
                ),
                Expanded(
                  child: TabBarView(controller: _controller, children: tabView),
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
