import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../services/database_service.dart';

class SearchViewModel extends BaseViewModel {
  final _databaseService = locator<DatabaseService>();
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  Stream<QuerySnapshot<Map<String, dynamic>>> getResults() {
    return _databaseService.store
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchQuery.toUpperCase())
        .snapshots();
  }

  void updateSearchQuery(String query) {
    print(query);
    searchQuery = query;
    print('about to rebuild');
    rebuildUi();
  }
}
