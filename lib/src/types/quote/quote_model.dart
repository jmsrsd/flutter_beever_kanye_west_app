import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

@immutable
class QuoteModel extends Equatable {
  const QuoteModel({this.quote});

  final String? quote;

  factory QuoteModel.fromMap(Map<String, dynamic> data) => QuoteModel(
        quote: data['quote'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'quote': quote,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuoteModel].
  factory QuoteModel.fromJson(String data) {
    return QuoteModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuoteModel] to a JSON string.
  String toJson() => json.encode(toMap());

  QuoteModel copyWith({
    String? quote,
  }) {
    return QuoteModel(
      quote: quote ?? this.quote,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [quote];
}
