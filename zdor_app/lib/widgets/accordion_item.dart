import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

extension AccordionItem on AccordionSection {
  static AccordionSection buildAccordionSection({
    required headerText,
    required headerStyle,
    required index,
    nestedWidget,
  }) {
    return AccordionSection(
        //isOpen : true,
        isOpen: index == 0 ? true : false,
        header: Text(headerText, style: headerStyle),
        contentHorizontalPadding: 40,
        contentVerticalPadding: 20,
        content: nestedWidget != null ? nestedWidget! : Text("Widget non trovato"));
  }
}

