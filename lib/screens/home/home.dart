import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/screens/new-movement/new-movement.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/screens/home/components/expenses_preview.dart';
import 'package:makeitcount/state/providers/movements/movements_repository.provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: DateTime.now().month - 1,
      length: 12,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final movementsRepo = ref.watch(movementsRepositoryProvider);
    // I show only the three / four last movements
    // To see all others you need to use the See all page
    final movementsPreview =
        movementsRepo.getMovementsByMonth(DateTime.now().month, limit: 3);

    final highlightColor = Theme.of(context).colorScheme.primaryContainer;
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'Otcober',
      'November',
      'December',
    ];

    final toolbarHeight = MediaQuery.of(context).size.height * 0.10;

    return Scaffold(
      appBar: AppBar(
        notificationPredicate: (_) => false,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        forceMaterialTransparency: true,
        // toolbarHeight: 75,
        toolbarHeight: toolbarHeight,
        title: Container(
          margin: const EdgeInsets.only(top: 25),
          child: const Text("Good morning !",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              )),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(toolbarHeight),
          child: Container(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: ClipRRect(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SizedBox(
                  // height: 50,
                  height: MediaQuery.of(context).size.height * 0.075,
                  child: Row(
                    children: [
                      // TODO: should I keep arrows ?
                      IconButton(
                          onPressed: () {
                            _tabController.animateTo(_tabController.index - 1);
                          },
                          icon: const Icon(Icons.chevron_left)),
                      Expanded(
                        child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: highlightColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            indicatorPadding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 7,
                            ),
                            // labelColor: Colors.white,
                            // unselectedLabelColor: Colors.white,
                            tabs: months.map((m) {
                              return Tab(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    Text(m,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w200,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ]));
                            }).toList()),
                      ),
                      IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {
                            _tabController.animateTo(_tabController.index + 1);
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        // padding: const EdgeInsets.only(left: 15.0, right: 15.0)
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
              controller: _tabController,
              children: List.filled(12, 0)
                  .asMap()
                  .entries
                  .map((x) => ExpensesPreview(
                        month: x.key + 1,
                      ))
                  .toList() as List<Widget>),
        ),
      ),
      // TODO: keep it centered or on the right
      // Also if in center, should it have a label or only thep plus sign ?
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFullScreenDialog(
            context,
            _tabController,
            movementsPreview,
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void showFullScreenDialog(
  BuildContext context,
  TabController tabController,
  List<MovementModel> movementsPreview,
) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // Allow closing by tapping outside
    barrierLabel: "Dismiss",
    barrierColor: Colors.black54, // Background color
    transitionDuration: Duration(milliseconds: 300), // Animation duration
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return NewMovement(
          selectedMonth: tabController.index + 1,
          movementsPreview: movementsPreview);
    },
    transitionBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1), // Start from bottom
          end: Offset.zero, // End at the center
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut, // Easing curve
        )),
        child: child,
      );
    },
  );
}
