// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverse_geocoding_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReverseGeocodingStore on _ReverseGeocodingStoreBase, Store {
  final _$latLngAtom = Atom(name: '_ReverseGeocodingStoreBase.latLng');

  @override
  LatLng get latLng {
    _$latLngAtom.reportRead();
    return super.latLng;
  }

  @override
  set latLng(LatLng value) {
    _$latLngAtom.reportWrite(value, super.latLng, () {
      super.latLng = value;
    });
  }

  final _$_ReverseGeocodingStoreBaseActionController =
      ActionController(name: '_ReverseGeocodingStoreBase');

  @override
  void changeLatLng(LatLng value) {
    final _$actionInfo = _$_ReverseGeocodingStoreBaseActionController
        .startAction(name: '_ReverseGeocodingStoreBase.changeLatLng');
    try {
      return super.changeLatLng(value);
    } finally {
      _$_ReverseGeocodingStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
latLng: ${latLng}
    ''';
  }
}
