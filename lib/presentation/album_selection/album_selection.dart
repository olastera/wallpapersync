import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/album_card_widget.dart';
import './widgets/album_preview_widget.dart';

class AlbumSelection extends StatefulWidget {
  const AlbumSelection({Key? key}) : super(key: key);

  @override
  State<AlbumSelection> createState() => _AlbumSelectionState();
}

class _AlbumSelectionState extends State<AlbumSelection>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _selectedAlbums = <String>{};
  bool _isLoading = false;
  bool _isSearching = false;
  String _searchQuery = '';

  // Mock data for Google Photos albums
  final List<Map<String, dynamic>> _googlePhotosAlbums = [
    {
      "id": "gp_001",
      "title": "Vacaciones en Barcelona",
      "photoCount": 127,
      "coverImage":
          "https://images.pexels.com/photos/1388030/pexels-photo-1388030.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-10",
      "previewImages": [
        "https://images.pexels.com/photos/1388030/pexels-photo-1388030.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388031/pexels-photo-1388031.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388032/pexels-photo-1388032.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388033/pexels-photo-1388033.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388034/pexels-photo-1388034.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388035/pexels-photo-1388035.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388036/pexels-photo-1388036.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388037/pexels-photo-1388037.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1388038/pexels-photo-1388038.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
    {
      "id": "gp_002",
      "title": "Paisajes Naturales",
      "photoCount": 89,
      "coverImage":
          "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-12",
      "previewImages": [
        "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417075/pexels-photo-417075.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417076/pexels-photo-417076.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417077/pexels-photo-417077.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417078/pexels-photo-417078.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417079/pexels-photo-417079.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417080/pexels-photo-417080.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417081/pexels-photo-417081.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/417082/pexels-photo-417082.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
    {
      "id": "gp_003",
      "title": "Arquitectura Moderna",
      "photoCount": 156,
      "coverImage":
          "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-08",
      "previewImages": [
        "https://images.pexels.com/photos/323780/pexels-photo-323780.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323781/pexels-photo-323781.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323782/pexels-photo-323782.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323783/pexels-photo-323783.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323784/pexels-photo-323784.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323785/pexels-photo-323785.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323786/pexels-photo-323786.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323787/pexels-photo-323787.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/323788/pexels-photo-323788.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
    {
      "id": "gp_004",
      "title": "Comida y Restaurantes",
      "photoCount": 73,
      "coverImage":
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-14",
      "previewImages": [
        "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640778/pexels-photo-1640778.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640779/pexels-photo-1640779.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640780/pexels-photo-1640780.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640781/pexels-photo-1640781.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640782/pexels-photo-1640782.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640783/pexels-photo-1640783.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640784/pexels-photo-1640784.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1640785/pexels-photo-1640785.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
    {
      "id": "gp_005",
      "title": "Mascotas",
      "photoCount": 94,
      "coverImage":
          "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-11",
      "previewImages": [
        "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108100/pexels-photo-1108100.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108101/pexels-photo-1108101.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108102/pexels-photo-1108102.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108103/pexels-photo-1108103.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108104/pexels-photo-1108104.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108105/pexels-photo-1108105.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108106/pexels-photo-1108106.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1108107/pexels-photo-1108107.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
    {
      "id": "gp_006",
      "title": "Arte y Cultura",
      "photoCount": 112,
      "coverImage":
          "https://images.pexels.com/photos/1266808/pexels-photo-1266808.jpeg?auto=compress&cs=tinysrgb&w=800",
      "isSelected": false,
      "lastUpdated": "2025-07-09",
      "previewImages": [
        "https://images.pexels.com/photos/1266808/pexels-photo-1266808.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266809/pexels-photo-1266809.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266810/pexels-photo-1266810.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266811/pexels-photo-1266811.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266812/pexels-photo-1266812.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266813/pexels-photo-1266813.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266814/pexels-photo-1266814.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266815/pexels-photo-1266815.jpeg?auto=compress&cs=tinysrgb&w=400",
        "https://images.pexels.com/photos/1266816/pexels-photo-1266816.jpeg?auto=compress&cs=tinysrgb&w=400",
      ]
    },
  ];

  // Mock data for device albums
  final List<Map<String, dynamic>> _deviceAlbums = [
    {
      "id": "device_001",
      "title": "Cámara",
      "photoCount": 234,
      "coverImage":
          "https://images.pixabay.com/photo-2016/11/29/05/45/astronomy-1867616_1280.jpg",
      "isSelected": false,
      "lastUpdated": "2025-07-15",
      "previewImages": [
        "https://images.pixabay.com/photo-2016/11/29/05/45/astronomy-1867616_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/46/astronomy-1867617_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/47/astronomy-1867618_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/48/astronomy-1867619_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/49/astronomy-1867620_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/50/astronomy-1867621_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/51/astronomy-1867622_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/52/astronomy-1867623_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/29/05/53/astronomy-1867624_1280.jpg",
      ]
    },
    {
      "id": "device_002",
      "title": "Capturas de Pantalla",
      "photoCount": 67,
      "coverImage":
          "https://images.pixabay.com/photo-2016/11/19/14/00/code-1839406_1280.jpg",
      "isSelected": false,
      "lastUpdated": "2025-07-14",
      "previewImages": [
        "https://images.pixabay.com/photo-2016/11/19/14/00/code-1839406_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/01/code-1839407_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/02/code-1839408_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/03/code-1839409_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/04/code-1839410_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/05/code-1839411_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/06/code-1839412_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/07/code-1839413_1280.jpg",
        "https://images.pixabay.com/photo-2016/11/19/14/08/code-1839414_1280.jpg",
      ]
    },
    {
      "id": "device_003",
      "title": "Descargas",
      "photoCount": 45,
      "coverImage":
          "https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      "isSelected": false,
      "lastUpdated": "2025-07-13",
      "previewImages": [
        "https://images.unsplash.com/photo-1518709268805-4e9042af2176?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268806-4e9042af2177?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268807-4e9042af2178?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268808-4e9042af2179?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268809-4e9042af2180?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268810-4e9042af2181?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268811-4e9042af2182?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268812-4e9042af2183?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1518709268813-4e9042af2184?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
      ]
    },
    {
      "id": "device_004",
      "title": "WhatsApp Images",
      "photoCount": 189,
      "coverImage":
          "https://images.unsplash.com/photo-1611224923853-80b023f02d71?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      "isSelected": false,
      "lastUpdated": "2025-07-15",
      "previewImages": [
        "https://images.unsplash.com/photo-1611224923853-80b023f02d71?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923854-80b023f02d72?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923855-80b023f02d73?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923856-80b023f02d74?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923857-80b023f02d75?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923858-80b023f02d76?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923859-80b023f02d77?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923860-80b023f02d78?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
        "https://images.unsplash.com/photo-1611224923861-80b023f02d79?ixlib=rb-4.0.3&auto=format&fit=crop&w=400&q=80",
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _loadAlbums();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Future<void> _loadAlbums() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _refreshAlbums() async {
    await _loadAlbums();
  }

  void _toggleAlbumSelection(String albumId) {
    setState(() {
      if (_selectedAlbums.contains(albumId)) {
        _selectedAlbums.remove(albumId);
      } else {
        _selectedAlbums.add(albumId);
      }
    });
  }

  void _showAlbumPreview(Map<String, dynamic> album) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AlbumPreviewWidget(
        album: album,
        onClose: () => Navigator.pop(context),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredAlbums(
      List<Map<String, dynamic>> albums) {
    if (_searchQuery.isEmpty) return albums;

    return albums.where((album) {
      final title = (album['title'] as String).toLowerCase();
      return title.contains(_searchQuery);
    }).toList();
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Buscar álbumes...',
          prefixIcon: CustomIconWidget(
            iconName: 'search',
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            size: 20,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  child: CustomIconWidget(
                    iconName: 'clear',
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildAlbumGrid(List<Map<String, dynamic>> albums) {
    if (_isLoading) {
      return _buildLoadingGrid();
    }

    if (albums.isEmpty) {
      return _buildEmptyState();
    }

    final filteredAlbums = _getFilteredAlbums(albums);

    if (filteredAlbums.isEmpty && _searchQuery.isNotEmpty) {
      return _buildNoSearchResults();
    }

    return RefreshIndicator(
      onRefresh: _refreshAlbums,
      child: GridView.builder(
        padding: EdgeInsets.all(3.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 100.w > 600 ? 3 : 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.w,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredAlbums.length,
        itemBuilder: (context, index) {
          final album = filteredAlbums[index];
          final isSelected = _selectedAlbums.contains(album['id']);

          return AlbumCardWidget(
            album: album,
            isSelected: isSelected,
            onTap: () => _toggleAlbumSelection(album['id']),
            onLongPress: () => _showAlbumPreview(album),
          );
        },
      ),
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(3.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 100.w > 600 ? 3 : 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 3.w,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest
                  .withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 2.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Container(
                          height: 1.5.h,
                          width: 15.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHighest
                                .withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'photo_library',
            size: 15.w,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 2.h),
          Text(
            'No hay álbumes disponibles',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Intenta actualizar o verifica los permisos',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            size: 15.w,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: 2.h),
          Text(
            'No se encontraron álbumes',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Intenta con otros términos de búsqueda',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _continueToHomeDashboard() {
    if (_selectedAlbums.isNotEmpty) {
      Navigator.pushNamed(context, '/home-dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Álbumes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _searchQuery = '';
                }
              });
            },
            icon: CustomIconWidget(
              iconName: _isSearching ? 'close' : 'search',
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Google Photos'),
            Tab(text: 'Dispositivo'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_isSearching) _buildSearchBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildAlbumGrid(_googlePhotosAlbums),
                  _buildAlbumGrid(_deviceAlbums),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _selectedAlbums.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: _continueToHomeDashboard,
              icon: CustomIconWidget(
                iconName: 'arrow_forward',
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
              label: Text(
                'Continuar (${_selectedAlbums.length})',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            )
          : null,
    );
  }
}
