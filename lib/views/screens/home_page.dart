import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maush_tech_task/controller/album_controller.dart';
import 'package:maush_tech_task/views/widgets/album_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<AlbumController>().loadMoreItems();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 50,
          child: TextField(
            controller: _textEditingController,
            focusNode: _focusNode,
            onChanged: (value) {
              context.read<AlbumController>().searchAlbum(value);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              hintText: 'Search Album',
            ),
          ),
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Consumer<AlbumController>(
              builder: (BuildContext context, provider, Widget? child) {
                if (_textEditingController.text.isNotEmpty &&
                    provider.searchList.isEmpty) {
                  return const Center(
                    child: Text('No Album Found'),
                  );
                }

                if (provider.isLoading && provider.paginatedAlbumList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: scrollController,
                        itemCount: _textEditingController.text.isNotEmpty
                            ? provider.searchList.length
                            : provider.paginatedAlbumList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 4,
                          childAspectRatio:
                              orientation == Orientation.portrait ? .8 : .7,
                          mainAxisSpacing: 5.h,
                          crossAxisSpacing: 5.w,
                        ),
                        itemBuilder: (context, index) {
                          final data = _textEditingController.text.isNotEmpty
                              ? provider.searchList[index]
                              : provider.paginatedAlbumList[index];
                          return AlbumCard(
                            title: data.title ?? '',
                            url: data.albumImages![0].url ?? '',
                            albumImages: data,
                          );
                        },
                      ),
                    ),
                    if (provider.isPaginating)
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: CircularProgressIndicator(),
                      )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
