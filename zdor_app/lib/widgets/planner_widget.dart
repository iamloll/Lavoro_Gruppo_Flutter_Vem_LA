import 'package:flutter/material.dart';
import 'package:zdor_app/widgets/accordion_list.dart';

class PlannerWidget extends StatelessWidget {
  PlannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 1, 1, 1),
        appBar: AppBar(
          title: const Text('Planner Pasti'),
          actions: [
            IconButton(
              onPressed: () => {print("Menu button pressed")}, 
              icon: const Icon(Icons.more_vert_rounded))            
          ],
        ),
        body : 
        AccordionList()
    );
  }
}
