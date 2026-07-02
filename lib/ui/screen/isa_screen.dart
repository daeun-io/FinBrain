import 'package:finbrain/ui/viewmodel/isa_viewmodel.dart';
import 'package:finbrain/ui/viewmodel/product_viewmodel.dart';
import 'package:finbrain/themes/colors.dart';
import 'package:finbrain/product_categories.dart';
import 'package:finbrain/ui/screen/isa_base_screen.dart';
import 'package:finbrain/ui/screen/isa_mp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IsaScreen extends ConsumerStatefulWidget {
  const IsaScreen({super.key});

  @override
  ConsumerState<IsaScreen> createState() => _IsaScreenState();
}

class _IsaScreenState extends ConsumerState<IsaScreen> with SingleTickerProviderStateMixin{
  late TabController _controller;

  @override
  void initState(){
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener((){
      if(!_controller.indexIsChanging){
        switch(_controller.index){
          case 0: ref.read(isaJoinStatusViewModelProvider.notifier).fetchIsaJoinStatus("1"); break;
          case 1: ref.read(isaManagementStatusViewModelProvider.notifier).fetchIsaManagementStatus("1"); break;
          default: ref.read(productViewmodelProvider.notifier).fetchIsaMpProducts("1");
        }
      }
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_){
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.zero,
              color: primary100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              elevation: 0,
              child: TabBar(
                controller: _controller,
                padding: EdgeInsets.zero,
                labelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: white,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: textSecondary,
                ),
                indicator: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: primary700,
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("업권별 가입 현황"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("운용 현황"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    child: const Text("MP 수익률"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  const IsaBaseScreen(category: FilterTextCategory.isaJoin),
                  const IsaBaseScreen(
                    category: FilterTextCategory.isaManagement,
                  ),
                  const IsaMpScreen(),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
