import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';

//Metodo utilizzabile su qualsiasi AccordionSection
extension AccordionItem on AccordionSection {
  static AccordionSection buildAccordionSection({
    required headerText,
    required headerStyle,
    required isOpen,
    nestedWidget,
  }) {
    //Costruisco un AccordionSection passandogli alcuni dettagli di stile
    return AccordionSection(
        isOpen: isOpen, //Condizionale per l'apertura
        header: Text(headerText, style: headerStyle),
        contentHorizontalPadding: 8,
        contentVerticalPadding: 15,
        content: nestedWidget != null ? nestedWidget! : const Text("Widget non trovato")); //Widget da mostrare al suo interno
  }
}
