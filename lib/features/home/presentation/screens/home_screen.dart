import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:ps_task/core/theme/app_colors.dart';
import 'package:ps_task/core/theme/app_fonts.dart';
import 'package:ps_task/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:ps_task/features/auth/presentation/screens/login_screen.dart';
import 'package:ps_task/features/home/data/models/post_model.dart';
import 'dart:convert';

import 'package:ps_task/features/home/presentation/bloc/post_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<PostModel> _posts = [];
  List<PostModel> _filteredPosts = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
    _searchController.addListener(_filterPosts);
  }

  Future<void> _fetchPosts() async {
    PostsBloc.get(context).add(GetAllPostsEvent(context));
    /*

try {
      final response = await http.get(Uri.parse("YOUR_API_ENDPOINT_HERE"));
      if (response.statusCode == 200) {
        final List decodedJson = json.decode(response.body) as List;
        final List<PostModel> postModels = decodedJson
            .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
            .toList();

        setState(() {
          _posts = postModels;
          _filteredPosts = postModels;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      log(e.toString());
      setState(() {
        _isLoading = false;
      });
    }

    */
  }

  void _filterPosts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPosts = _posts.where((post) {
        return post.title.toLowerCase().contains(query) ||
               post.body.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    AuthBlocBloc.get(context).add(LogoutEvent(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0 ? _buildHomeTab() : _buildProfileTab(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary_1,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeTab() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home', style: AppFonts.seezBold20),
        backgroundColor: AppColors.primary_1,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                    itemCount: _filteredPosts.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_filteredPosts[index].title),
                        subtitle: Text(_filteredPosts[index].body),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppFonts.seezBold20),
        backgroundColor: AppColors.primary_1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user?.displayName ?? 'N/A'}', style: AppFonts.seezBlack18),
            Text('Email: ${user?.email ?? 'N/A'}', style: AppFonts.seezBlack18),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.white, 
                backgroundColor: AppColors.primary_1,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: AppFonts.seezBold20,
              ),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}