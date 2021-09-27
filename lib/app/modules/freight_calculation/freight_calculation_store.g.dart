// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freight_calculation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FreightCalculationStore on _FreightCalculationStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_FreightCalculationStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$moveClientAtom =
      Atom(name: '_FreightCalculationStoreBase.moveClient');

  @override
  bool get moveClient {
    _$moveClientAtom.reportRead();
    return super.moveClient;
  }

  @override
  set moveClient(bool value) {
    _$moveClientAtom.reportWrite(value, super.moveClient, () {
      super.moveClient = value;
    });
  }

  final _$polylinesAtom = Atom(name: '_FreightCalculationStoreBase.polylines');

  @override
  List<LatLng> get polylines {
    _$polylinesAtom.reportRead();
    return super.polylines;
  }

  @override
  set polylines(List<LatLng> value) {
    _$polylinesAtom.reportWrite(value, super.polylines, () {
      super.polylines = value;
    });
  }

  final _$latLngClientAtom =
      Atom(name: '_FreightCalculationStoreBase.latLngClient');

  @override
  LatLng get latLngClient {
    _$latLngClientAtom.reportRead();
    return super.latLngClient;
  }

  @override
  set latLngClient(LatLng value) {
    _$latLngClientAtom.reportWrite(value, super.latLngClient, () {
      super.latLngClient = value;
    });
  }

  final _$latLngCompanyAtom =
      Atom(name: '_FreightCalculationStoreBase.latLngCompany');

  @override
  LatLng get latLngCompany {
    _$latLngCompanyAtom.reportRead();
    return super.latLngCompany;
  }

  @override
  set latLngCompany(LatLng value) {
    _$latLngCompanyAtom.reportWrite(value, super.latLngCompany, () {
      super.latLngCompany = value;
    });
  }

  final _$setPolylinesAsyncAction =
      AsyncAction('_FreightCalculationStoreBase.setPolylines');

  @override
  Future<void> setPolylines() {
    return _$setPolylinesAsyncAction.run(() => super.setPolylines());
  }

  final _$calculateDeliveryAsyncAction =
      AsyncAction('_FreightCalculationStoreBase.calculateDelivery');

  @override
  Future<void> calculateDelivery() {
    return _$calculateDeliveryAsyncAction.run(() => super.calculateDelivery());
  }

  final _$_FreightCalculationStoreBaseActionController =
      ActionController(name: '_FreightCalculationStoreBase');

  @override
  void changeMoveClient(bool value) {
    final _$actionInfo = _$_FreightCalculationStoreBaseActionController
        .startAction(name: '_FreightCalculationStoreBase.changeMoveClient');
    try {
      return super.changeMoveClient(value);
    } finally {
      _$_FreightCalculationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLatLngClient(LatLng value) {
    final _$actionInfo = _$_FreightCalculationStoreBaseActionController
        .startAction(name: '_FreightCalculationStoreBase.changeLatLngClient');
    try {
      return super.changeLatLngClient(value);
    } finally {
      _$_FreightCalculationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeLatLngCompany(LatLng value) {
    final _$actionInfo = _$_FreightCalculationStoreBaseActionController
        .startAction(name: '_FreightCalculationStoreBase.changeLatLngCompany');
    try {
      return super.changeLatLngCompany(value);
    } finally {
      _$_FreightCalculationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
moveClient: ${moveClient},
polylines: ${polylines},
latLngClient: ${latLngClient},
latLngCompany: ${latLngCompany}
    ''';
  }
}
