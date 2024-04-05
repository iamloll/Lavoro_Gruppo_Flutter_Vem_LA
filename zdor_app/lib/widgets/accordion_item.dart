import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

extension AccordionItem on AccordionSection {
  static AccordionSection buildAccordionSection({
    required headerText,
    required headerStyle,
    required isOpen,
    nestedWidget,
  }) {
    return AccordionSection(
        isOpen: isOpen,
        header: Text(headerText, style: headerStyle),
        contentHorizontalPadding: 8,
        contentVerticalPadding: 15,
        content: nestedWidget != null ? nestedWidget! : const Text("Widget non trovato"));
  }
}
