import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/screens/home/bloc/home_bloc.dart';
import 'package:e_commerce/screens/home/models/home_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:readmore/readmore.dart';

class ProductTile extends StatelessWidget {
  final HomeProductModel productItem;
  final HomeBloc homeBloc;
  ProductTile({
    required this.productItem,
    required this.homeBloc,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 80,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: productItem.image!,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              ReadMoreText(
                productItem.title.toString(),
                trimLines: 2,
                trimMode: TrimMode.Line,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                productItem.category.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade800,
                ),
              ),
              Row(
                children: [
                  Text(
                    "\$" + productItem.price.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(ProductiWishListButtonClickedEvent(
                        productModel: productItem,
                      ));
                    },
                    icon: Icon(
                      Icons.favorite_border,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(ProductiCartButtonClickedEvent(
                        productModel: productItem,
                      ));
                    },
                    icon: Icon(
                      Icons.add_shopping_cart_outlined,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .then(delay: 200.ms) // baseline=800ms
        .slide();
  }
}
