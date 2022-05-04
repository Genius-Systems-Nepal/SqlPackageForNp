// ignore_for_file: unnecessary_this, file_names

import 'package:flutter/material.dart';
import 'package:nepali_patro_sql_package/loaders/dataLoaders.dart';
import 'package:nepali_patro_sql_package/utils/dateconverter/nsmapping.dart';

abstract class SingleTonAbstractClass {
  @protected
  NsMapping? nsMapping;
  @protected
  DataLoaders? dataLoaders;

  setDataLoaders(DataLoaders data) {
    this.dataLoaders = data;
  }

  DataLoaders? getDataLoaders() {
    return dataLoaders;
  }

  setNsMapping() {
    nsMapping = NsMapping()..initTithiData();
  }

  NsMapping? getNsMapping() {
    return nsMapping;
  }

  reset() {
    setNsMapping();
    return nsMapping;
  }
}

class DataLoaderState extends SingleTonAbstractClass {
  static final DataLoaderState _instance = DataLoaderState._internal();

  factory DataLoaderState() {
    return _instance;
  }

  DataLoaderState._internal() {
    dataLoaders = DataLoaders();
  }
}

class NsMappingState extends SingleTonAbstractClass {
  static final NsMappingState _instance = NsMappingState._internal();

  factory NsMappingState() {
    return _instance;
  }

  NsMappingState._internal() {
    nsMapping = NsMapping();
  }
}
