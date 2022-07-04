import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_deliver/core/constants/image/image_constatns.dart';
import 'package:food_deliver/core/extension/context_extensions.dart';
import 'package:food_deliver/core/init/language/locale_keys.dart';
import 'package:food_deliver/core/navigator/navigator_manager.dart';
import 'package:food_deliver/screen/home/home_viewmodel/home_viewmodel.dart';
import 'package:food_deliver/screen/product_detail/view/product_detail_view.dart';
import 'package:food_deliver/screen/product_detail/viewmodel/product_detail_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../product/price_text.dart';
import '../../../product/search_text_field.dart';
import '../../../user_data.dart';
import '../../bottom_navigation/viewmodel/bottom_navigation_viewmodel.dart';
import '../model/category_model.dart';
import '../../bottom_navigation/model/product_model.dart';

class HomeView extends StatefulWidget {
  final BottomNavigationViewmodel navigationViewmodel;
  const HomeView({Key? key, required this.navigationViewmodel})
      : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with AutomaticKeepAliveClientMixin<HomeView>, NavigatorManager {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final viewmodel = Provider.of<HomeViewmodel>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: _nameAndProfileImage(),
          actions: [_notificationButton],
        ),
        body: Padding(
          padding: context.paddingNormal,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(LocaleKeys.whatDoYouWantToOrderToday.tr()),
                const SizedBox(height: 10),
                SearchTextField(
                    context: context, controllers: _searchController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: viewmodel.categorys!.entries
                      .map((e) => _categoryCard(viewmodel, e.value, e.key))
                      .toList(),
                ),
                const SizedBox(height: 20),
                _promotionsCard(),
                const SizedBox(height: 20),
                Text(LocaleKeys.mostPopular.tr(),
                    style: _promotionsAndMostPopularStyle),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    height: 170,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: viewmodel.productList != null
                          ? viewmodel.productList!
                              .map((e) => _mostPopularCard(e))
                              .toList()
                          : [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mostPopularCard(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          var result = await navigateToWidgetWithValue(
            context,
            ChangeNotifierProvider(
              create: (_) => ProductDetailViewmodel(product),
              child: const ProductDetailView(),
            ),
          );
          widget.navigationViewmodel.getProductsBasketMap(result);
        },
        child: Container(
          width: context.width / 2.5,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffD9C9C9),
                Color(0xffD5D3D3),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              product.image != null
                  ? Image.asset(ImageConstants.instance.toPng(product.image!))
                  : const SizedBox(),
              Text(product.title ?? ""),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PriceText(
                      context: context,
                      text: product.price.toString(),
                    ),
                    IconButton(
                      onPressed: () async {
                        await navigateToWidgetWithValue(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => ProductDetailViewmodel(product),
                            child: const ProductDetailView(),
                          ),
                        );
                      },
                      icon:
                          Icon(Icons.add_circle, color: Colors.green.shade700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _promotionsCard() {
    return Stack(
      children: [
        SizedBox(width: context.width, height: 170),
        Positioned(
          top: 30,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xffD21670),
                  const Color(0xff531D99).withOpacity(0.6),
                ],
              ),
            ),
            width: context.width - 67,
            height: 140,
            padding: context.paddingNormal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.todaysOffer.tr(),
                  style: context.textTheme.subtitle1
                      ?.copyWith(color: const Color(0xffD4D4D4)),
                ),
                Text(
                  LocaleKeys.freeBoxofFries.tr(),
                  style: context.textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${LocaleKeys.onAllOthersAbove.tr()} \$200",
                  style: context.textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
        Text(LocaleKeys.promotions.tr(), style: _promotionsAndMostPopularStyle),
        Positioned(
          right: 0,
          child: Image.asset(ImageConstants.instance.toPng("png_fries")),
        )
      ],
    );
  }

  TextStyle? get _promotionsAndMostPopularStyle => context.textTheme.titleLarge
      ?.copyWith(color: const Color(0xff463A3A), fontWeight: FontWeight.bold);

  Column _categoryCard(
      HomeViewmodel viewmodel, CategoryModel model, int index) {
    return Column(
      children: [
        const SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                viewmodel.selectedCategory == index
                    ? const Color(0xffD21670)
                    : const Color(0xffD9C9C9)),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
            maximumSize: MaterialStateProperty.all(
                Size(context.width * 0.18, context.width * 0.18)),
            minimumSize: MaterialStateProperty.all(
                Size(context.width * 0.18, context.width * 0.18)),
          ),
          onPressed: () {
            viewmodel.selectedCategory = index;
          },
          child: Image.asset(model.image),
        ),
        const SizedBox(height: 20),
        Text(model.title),
      ],
    );
  }

  Padding get _notificationButton {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          ),
          const CircleAvatar(backgroundColor: Colors.red, radius: 5),
        ],
      ),
    );
  }

  Row _nameAndProfileImage() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 30,
            width: 30,
            child: FadeInImage.assetNetwork(
              placeholder: ImageConstants.instance.toGif("gif_loading"),
              image: context.read<UserData>().user?.profileImage ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text("${LocaleKeys.hi.tr()}, ${context.read<UserData>().user?.name}",
            style: context.textTheme.titleLarge)
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
