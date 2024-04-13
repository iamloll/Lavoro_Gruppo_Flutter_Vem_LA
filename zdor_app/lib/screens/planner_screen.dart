import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdor_app/states/planner_state.dart';
import 'package:zdor_app/widgets/planner/accordion_list.dart';

class PlannerWidget extends StatelessWidget {
  const PlannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 1, 1),
        appBar: AppBar(
          title: const Center(child: Text('Planner Pasti')),
        ),
        body : AccordionList()
    );
  }
}
