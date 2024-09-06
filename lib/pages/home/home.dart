import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makeitcount/state/models/movement.model.dart';
import 'package:makeitcount/pages/home/components/expenses_preview.dart';
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
      initialIndex: 0,
      length: 12,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final movementsRepo = ref.watch(movementsRepositoryProvider);
    // I show only the three / four last movements
    // To see all others you need to use the See all page
    final movementsPreview = movementsRepo.getMovementsByMonth(9, limit: 3);

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
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: TabBarView(
              controller: _tabController,
              children: List.filled(12, 0)
                  .map((x) => ExpensesPreview(
                        movements: movementsPreview,
                      ))
                  .toList() as List<Widget>),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            movementsPreview
                .add(MovementModel(0, "NEW", 33.33, "TEST", "NONE", 9, 1));
          });
          // TODO:
          // I think I should reverse options.
          // First I need to check if I correctly inserted the new entry in DB.
          // If it succeded then I can add it to local state.
          movementsRepo.addMovement("NEW", "TEST", 33.33);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
