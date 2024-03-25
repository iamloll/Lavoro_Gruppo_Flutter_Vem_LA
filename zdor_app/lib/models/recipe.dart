// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Recipe {
  final String? id;
  final String? title;
  final String? category;
  final String? image;
  final List<dynamic>? ingredients_list;
  final String? procedure;
  final String? prep_time;


  Recipe({
    this.id,
    this.title, 
    this.category, 
    this.image, 
    this.ingredients_list, 
    this.procedure, 
    this.prep_time,    
  });

  

  Recipe copyWith({
    String? id,
    String? title,
    String? category,
    String? image,
    List<dynamic>? ingredients_list,
    String? procedure,
    String? prep_time,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      image: image ?? this.image,
      ingredients_list: ingredients_list ?? this.ingredients_list,
      procedure: procedure ?? this.procedure,
      prep_time: prep_time ?? this.prep_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'category': category,
      'image': image,
      'ingredients_list': ingredients_list,
      'procedure': procedure,
      'prep_time': prep_time,
    };
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromRawJson(String str) => Recipe.fromJson(json.decode(str));

  factory Recipe.fromJson(Map<String, dynamic> map) => Recipe(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      ingredients_list: map['ingredients_list'] != null ? map['ingredients_list'] as List<dynamic> : null,
      procedure: map['procedure'] != null ? map['procedure'] as String : null,
      prep_time: map['prep_time'] != null ? map['prep_time'] as String : null
  );

  @override
  String toString() {
    return 'Recipe(id: $id, title: $title, category: $category, image: $image, ingredients_list: $ingredients_list, procedure: $procedure, prep_time: $prep_time)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.category == category &&
      other.image == image &&
      other.ingredients_list == ingredients_list &&
      other.procedure == procedure &&
      other.prep_time == prep_time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      category.hashCode ^
      image.hashCode ^
      ingredients_list.hashCode ^
      procedure.hashCode ^
      prep_time.hashCode;
  }
}
