import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../services/database_service.dart';

class SearchViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final TextEditingController searchController = TextEditingController();

  String _searchQuery = "";

  Stream<QuerySnapshot<Map<String, dynamic>>> getResults() {
    return _databaseService.store
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: _searchQuery.toUpperCase())
        .snapshots();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    rebuildUi();
  }
}
