import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/features/feature_gallery/bloc/predictions_bloc.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/shared/custom_app_bar.dart';
import 'package:baby_look/shared/generated_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late PageController pageController;
  int currentValue = 0;

  void _changePage(int? value) {
    pageController.jumpToPage(value!);

    setState(() {
      currentValue = value!;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Gallery'),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          CupertinoSlidingSegmentedControl(
            // backgroundColor: theme.colorScheme.secondary,
            groupValue: currentValue,
            children: {0: Text("All (12)"), 1: Text('Favourites (4)')},
            onValueChanged: _changePage,
          ),

          Expanded(
            child: PageView(
              onPageChanged: _changePage,
              controller: pageController,
              children: [_GalleryAll(), _GalleryFavourites()],
            ),
          ),
        ],
      ),
    );
  }
}

class _GalleryAll extends StatelessWidget {
  const _GalleryAll({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionsBloc, PredictionsBlocState>(
      builder: (context, state) {
        if (state is PredictionsBlocState_loaded) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppConstant.appPadding,
              crossAxisSpacing: AppConstant.appPadding,
              childAspectRatio: 3 / 4,
            ),
            itemCount: state.predictionList.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: AppConstant.heroTag,
                child: GeneratedCardWidget(
                  prediction: state.predictionList[index],
                  onCardTap: () {
                    context.push('/gallery/prediction_detail', extra: state.predictionList[index] );
                  },
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class _GalleryFavourites extends StatelessWidget {
  const _GalleryFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppConstant.appPadding,
        crossAxisSpacing: AppConstant.appPadding,
        childAspectRatio: 3 / 4,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Hero(
          tag: AppConstant.heroTag,
          child: GeneratedCardWidget(
            onCardTap: () => context.push('/gallery/prediction_detail'),
          ),
        );
      },
    );
  }
}
