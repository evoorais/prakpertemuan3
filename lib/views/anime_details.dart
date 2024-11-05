import 'package:flutter/material.dart';
import 'package:prakpertemuanketiga/presenters/anime_detail_presenter.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.endpoint});
  final int id;
  final String endpoint;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> implements AnimeDetailView {
  late AnimeDetailPresenter _presenter;
  bool _isLoading = true;
  Map<String, dynamic>? _detailData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _presenter = AnimeDetailPresenter(this);
    _presenter.loadDetailData(widget.endpoint, widget.id);
  }

  @override
  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  @override
  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showDetailData(Map<String, dynamic> detailData) {
    setState(() {
      _detailData = detailData;
    });
  }

  @override
  void showError(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Anime Detail",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            )
          : _errorMessage != null
              ? Center(
                  child: Text(
                    "Error: $_errorMessage",
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : _detailData != null
                  ? SingleChildScrollView(
                      child: Container(
                        color: Colors.grey[100],
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    _detailData!['images']?[0] ?? 'https://placehold.co/600x400',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network('https://placehold.co/600x400');
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  _detailData!['name'] ?? 'Unknown',
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.fingerprint, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Kekkei Genkai: ${_detailData!['personal']?['kekkeiGenkai'] ?? 'None'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.male, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Sex: ${_detailData!['personal']?['sex'] ?? 'Unknown'}",
                                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.person, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Status: ${_detailData!['personal']?['status'] ?? 'Unknown'}",
                                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.tv, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Anime: ${_detailData!['debut']?['anime'] ?? 'Unknown'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.category, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Classification: ${_detailData!['classification'] ?? 'Unknown'}",
                                      style: const TextStyle(fontSize: 18, color: Colors.black87),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Unique Traits: ${(_detailData!['uniqueTraits'] as List<dynamic>?)?.join(', ') ?? 'None'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.people, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Partner: ${_detailData!['personal']?['partner'] ?? 'None'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.family_restroom, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Family: ${(_detailData!['personal']?['family'] as List<dynamic>?)?.join(', ') ?? 'None'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.title, color: Colors.deepPurple, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Titles: ${(_detailData!['personal']?['titles'] as List<dynamic>?)?.join(', ') ?? 'None'}",
                                        style: const TextStyle(fontSize: 18, color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Center(
                      child: Text(
                        "Tidak ada data!",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
    );
  }
}
