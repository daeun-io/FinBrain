import 'package:finbrain/ui/viewmodel/current_ctg_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/current_page_viewmodel.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_base_screen.dart';
import 'package:finbrain/ui/screen/isa_mp_screen.dart';
import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/ui/widget/custom_tapbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 데이터 호출 스크린의 부모 스크린 + 탭 포함
// Parent screen of IsaBase and IsaMp Screen including tab
class IsaScreen extends ConsumerStatefulWidget {
  const IsaScreen({super.key});

  @override
  ConsumerState<IsaScreen> createState() => _IsaScreenState();
}

class _IsaScreenState extends ConsumerState<IsaScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;
  final tabList = ["가입 현황", "운용 현황", "MP 수익률"];
  final categories = const [
    ProductCategory.isaJoin,
    ProductCategory.isaManagement,
    ProductCategory.isaMp,
  ];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 3, initialIndex: 0, vsync: this);
    _controller.addListener(() {
      if (!_controller.indexIsChanging) {
        setState(() {
          currentIndex = _controller.index;
        });
        tapFunction(_controller.index);
      }
    });
  }

  // 탭 선택에 따라 데이터 불러오기
  // Fetch data based on tab index
  void tapFunction(int value) {
    ref
        .read(currentCtgViewmodelProvider.notifier)
        .setCurrentCtg(categories[value]);
    final page = ref.read(currentPageViewmodelProvider(categories[value]));
    if (ref.read(currentCtgViewmodelProvider) == categories[value]) {
      switch (value) {
        case 1:
          ref.read(fetchIsaMngmStatusViewmodelProvider(page));
        case 2:
          ref.read(fetchProductViewmodelProvider(categories[value], page));
        default:
          ref.read(fetchIsaJoinStatusViewmodelProvider(page));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            child: switch (currentIndex) {
              1 => const IsaBaseScreen(category: ProductCategory.isaManagement),
              2 => const IsaMpScreen(),
              _ => const IsaBaseScreen(category: ProductCategory.isaJoin),
            },
          ),
        ],
      ),
    );
  }
}
