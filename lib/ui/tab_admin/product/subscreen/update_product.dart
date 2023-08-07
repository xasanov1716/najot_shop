import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:najot_shop/ui/tab_client/widget/global_shimmer.dart';
import 'package:najot_shop/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/category_model.dart';
import '../../../../data/models/products_data_model.dart';
import '../../../../providers/category_provider.dart';
import '../../../../providers/product_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../auth/widgets/global_button.dart';
import '../../../auth/widgets/global_text_fields.dart';

class ProductUpdateScreen extends StatefulWidget {
  const ProductUpdateScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductUpdateScreen> createState() => _ProductUpdateScreenState();
}

class _ProductUpdateScreenState extends State<ProductUpdateScreen> {
  ImagePicker picker = ImagePicker();
  String imagePath = defaultConstantsImages;
  String currency = "";

  List<String> currencies = ["UZS", "USD", "RUB"];

  String selectedCurrency = "UZS";
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductsProvider>(context, listen: false).clearParameters();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Product Update"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Provider.of<CategoryProvider>(context, listen: false)
                  .clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  GlobalTextField(
                    hintText: "Product Name",
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productNameController,
                    title: '',
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    maxLine: 10,
                    hintText: "Description",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productDescController,
                    title: '',
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    hintText: "Product Count",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productCountController,
                    title: '',
                  ),
                  const SizedBox(height: 24),
                  GlobalTextField(
                    hintText: "Product Price",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productPriceController,
                    title: '',
                  ),
                  const SizedBox(height: 24),
                  DropdownButton(
                    value: selectedCurrency,
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: currencies.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  StreamBuilder<List<CategoryModel>>(
                    stream: context.read<CategoryProvider>().getCategories(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CategoryModel>> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? SizedBox(
                                height: 50,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    snapshot.data!.length,
                                    (index) {
                                      CategoryModel categoryModel =
                                          snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryId =
                                                categoryModel.categoryId;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: selectedCategoryId ==
                                                        categoryModel.categoryId
                                                    ? AppColors.globalActive
                                                        .withOpacity(0.6)
                                                    : AppColors.globalActive,
                                              ),
                                              height: 100,
                                              // margin: const EdgeInsets.all(16),
                                              padding: const EdgeInsets.all(5),
                                              child: Center(
                                                child: Text(
                                                  categoryModel.categoryName,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : const Center(child: Text("Empty!"));
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return const Center(child: Loading());
                    },
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 150,
                    height: 150,
                    color: AppColors.white,
                    child: TextButton(
                      onPressed: () {
                        showBottomSheetDialog();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).indicatorColor,
                      ),
                      child: imagePath == defaultConstantsImages
                          ? Text(
                              imagePath,
                              style: const TextStyle(color: Colors.black),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.productModel.productImages.first,
                                height: 100,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            const SizedBox(height: 10),
            GlobalButton(
              text: "Update product",
              onTap: () {
                context.read<ProductsProvider>().updateProduct(
                      context: context,
                      imagePath: widget.productModel.productImages.first,
                      productModel: widget.productModel,
                    );
              },
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 120.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26.r),
              topRight: Radius.circular(26.r),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }
  Future<void> _getFromGallery() async {
    List<XFile> xFiles = await picker.pickMultiImage(
      maxHeight: 512,
      maxWidth: 512,
    );
    // ignore: use_build_context_synchronously
    await Provider.of<ProductsProvider>(context, listen: false)
        .uploadProductImages(
      context: context,
      images: xFiles,
    );
  }
}
