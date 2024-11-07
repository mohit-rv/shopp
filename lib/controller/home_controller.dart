import 'package:carousel_slider/carousel_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:machine_test/controller/app_base_controller/app_base_conroller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends AppBaseController {
  int activeIndex = 0;
  final List<String> carouselItems = ['assets/images/banner_image.png','assets/images/banner_image.png'];

  final List<Map<String, dynamic>> productList = [
    {
      'image': 'assets/images/productImage1.png',
      'title': 'Beauty',
    },
    {
      'image': 'assets/images/offer.png',
      'title': 'Offers'
    },
    {
      'image': 'assets/images/girlImage.png',
      'title': 'Fashion',
    },
    {
      'image': 'assets/images/home.png',
      'title': 'Home'
    },
    {
      'image': 'assets/images/shirt.png',
      'title': 'Shirts'
    },
    {
      'image': 'assets/images/womenBag.png',
      'title': 'Woman Bag',
    },
    {
      'image': 'assets/images/Dress.png',
      'title': 'Dress'
    },
    {
      'image': 'assets/images/mobiles.png',
      'title': 'Mobiles'
    }
  ];


  // final List<Map<String, dynamic>> productsList2= [
  //   {'image':'assets/images/productImage1.png', 'title': 'Multi Kit','price':'500'},
  //   {'image':'assets/images/product2.png','title':'Lipstick','price':'400'}
  // ];

  final List<Map<String, dynamic>> productsList2 = [];
  var userData = [];
  var isLoading = true.obs;
  User? currentUser;


  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchProducts();

  }

  int selectedTabIndex = 0;

  void selectTab(int index) {
    selectedTabIndex = index;
    update();
  }

  var selectedIndex = 0;

  void updateSelectedIndex(index) {
    selectedIndex = index;
    update();
  }

  Future<void> fetchUserData() async {
    isLoading(true);
    try {
      currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        Stream<QuerySnapshot> usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();

        usersStream.listen((QuerySnapshot snapshot) {
          userData = snapshot.docs.map((doc) => doc.data()).toList();
          isLoading(false);
          update();
          print('user data is here------$userData');
        });
      } else {
        print('No user is currently signed in');
      }
    } catch (e) {
      isLoading(false);
      update();
      print('Error fetching user data: $e');
    }
  }

  Future<void> fetchProducts() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('products').get();
      productsList2.clear();
      for (var doc in snapshot.docs) {
        productsList2.add({
          'id': doc.id,
          'image': doc['image'],
          'title': doc['title'],
          'price': doc['price'],
        });
      }
      update();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> addProduct(String title, String imageUrl, String price) async {
    try {
      await FirebaseFirestore.instance.collection('products').add({

        'title': title,
        'image': imageUrl,
        'price': price,
      });
      Get.snackbar('Success', 'Product added successfully');
      await fetchProducts();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    if (productsList2.length > 2) {
      try {
        await FirebaseFirestore.instance.collection('products').doc(productId).delete();
        Get.snackbar('Success', 'Product deleted successfully');
        await fetchProducts();
      } catch (e) {
        print('Error deleting product: $e');
      }
    } else {
      Get.snackbar('Warning', 'At least two products must remain.');
    }
  }

  void callbackFunction(int index, CarouselPageChangedReason reason) {
    activeIndex = index;
    update();
    print('Page changed to: $index');
  }
}



