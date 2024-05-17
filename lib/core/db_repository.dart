//BD Shared Preferences para almancear datos de configuración inicial
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DBRepository {
  factory DBRepository() => _instance;
  DBRepository._internal() {
    onInit();
  }
  DatabaseClient? _db;

  late StoreRef _store = StoreRef.main();

  /// Singleton pattern
  static final DBRepository _instance = DBRepository._internal();

  /// Default constructor
  void onInit() {
    initDB();

    _store = StoreRef.main();
  }

  /// DB Instance
  Future<void> initDB() async {
    //debugPrint("antes inicializa db");
    // ignore:  prefer_final_locals
    try{
      final docDir = await getApplicationDocumentsDirectory();
    await docDir.create(recursive: true);
    // ignore: prefer_conditional_assignment
    if (_db == null) {
      _db =
          await databaseFactoryIo.openDatabase(join(docDir.path, 'ucuenca.db'));
    }
    debugPrint("inicializa db nosql");
    } catch (e){
      debugPrint("Error al inicializar la base de datos: $e");
    }
    
  }

  dynamic getDB() => _db;

  /// Add docs

  Future<void> set(String key, Map? value) async {
    // ignore: parameter_assignments,
    value ??= {};

    if (_db == null) {
      await initDB();
    }
    if (_db != null) {
      await _store.record(key).put(_db!, value);
    } else {
      debugPrint("Error: La base de datos no pudo ser inicializada.");
    }
  }

  Future<void> setStr(String key, String value) async {
    await _store.record(key).put(_db!, value);
  }

  Future<void> setInt(String key, int value) async {
    await _store.record(key).put(_db!, value);
  }

  /// Retrieve docs
  Future<Map> get(String key) async {
    try {
      if (_db == null) {
        //debugPrint("no hay db y debe iniciarse en db repository");
        await initDB();
      }
      return await _store.record(key).get(_db!) as Map;
    } on Exception catch (e) {
      debugPrint("Error al leer db. $e.toString()");
    }

    return {};
  }

  Future<String> getStr(String key) async =>
      await _store.record(key).get(_db!) as String;

  Future<int> getInt(String key) async =>
      await _store.record(key).get(_db!) as int;

  /// Remove docs
  Future<String> del(String key) async {
    await _store.record(key).delete(_db!);
    return "";
  }

  Future<void> deleteUser() async {
    if (_db == null) {
      await initDB();
    }
    final store = intMapStoreFactory.store("user");
    await store.delete(_db!);
  }


}
