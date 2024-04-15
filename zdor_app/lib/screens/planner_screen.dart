import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/planner/accordion_list.dart';

class PlannerWidget extends StatelessWidget {
  const PlannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TITOLO
        appBar: AppBar(
          title: const Center(child: Text('Planner Pasti')),
        ),
        //ACCORDION
        body : const AccordionList()
    );
  }
}
