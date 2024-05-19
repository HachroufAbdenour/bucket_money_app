import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/presentation/ui/transactions/transactions_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/ui/transactions/widgets/card_widget.dart';
import 'package:money_app/presentation/ui/transactions/widgets/price_widget.dart';
import 'package:money_app/presentation/ui/transactions/widgets/transaction_item.dart';
import 'package:money_app/shared/localization/keys.dart';
import 'package:money_app/shared/enums/screen_enums.dart';
import 'package:money_app/presentation/ui/onbording/view.dart';
import 'package:money_app/shared/utils/date_utils.dart';
import 'package:money_app/shared/utils/utils.dart';
import 'package:money_app/shared/widgets/app_buttons.dart';
import 'package:money_app/shared/widgets/app_progress.dart';
import 'package:money_app/shared/widgets/error_screen.dart';
import 'package:money_app/shared/widgets/responsive_view.dart';

class TransactionsScreen extends GetView<TransactionsController> {
  final _storage = GetStorage();
  File? _image;


void  getImage(File? _image, Function(File) setImage) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final image = File(pickedFile.path);
    setImage(image);
    GetStorage().write('image', pickedFile.path); // Save image path to storage
  } else {
    print('No image selected.');
  }
}



  TransactionsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsController>(
      autoRemove: false,
      builder: (_) {
        if (controller.screenEnum == ScreenEnums.error) {
          return const ErrorScreen();
        } else if (controller.screenEnum == ScreenEnums.loading) {
          return const AppProgress();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                StringsKeys.moneyApp.tr,
              ),
              actions: [
             SmallIconButton(
  onPressed: () {
    _showDeleteConfirmationDialog(context); // Show delete confirmation dialog
  },
  icon: isApple() ? CupertinoIcons.delete : Icons.delete_outline,
  color: Get.theme.appBarTheme.titleTextStyle?.color ?? Colors.white,
  message: StringsKeys.clear,
),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(250),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildBackground(),
                    PriseWidget(
                      price: controller.account?.price ?? 0.0,
                    ),
                    CardWidget(
                      onTapPay: controller.onTapPay,
                      onTapTopUp: controller.onTapTopUp,
                    ),
                  ],
                ),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white, // Set icon color to white
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Expanded(
                      child: Column(
                        children: [

                          Stack(children: [
         

Obx(() {
  return CircleAvatar(
    backgroundImage: controller.imagePath.isNotEmpty
        ? FileImage(File(controller.imagePath.value))
        : null,
    radius: 45,
  );
}),

GestureDetector(
  onTap: () async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Set the selected image path and trigger UI update
      controller.setImagePath(pickedFile.path);
    }
  },
  child: Icon(Icons.camera_alt, color: Colors.white), // Display camera icon over the avatar
),

                          ],),
    
                          SizedBox(height: 20),
                          Flexible(
                            child: Text(
                              _storage.read('fullName') ??
                                  '', // Example initials
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(StringsKeys.setting.tr),
                    onTap: () {
                      // Update the UI based on the item selected
                      // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
                    },
                  ),
                  ListTile(
                    title: Text(StringsKeys.privacy.tr),
                    onTap: () {
                      _launchURL(
                          'https://www.termsfeed.com/live/26ea4e76-94f3-4eb9-abdc-6f8f8e25bd6b');
                    },
                  ),

                  ListTile(
                    title: Text(StringsKeys.about.tr),
                    onTap: () {
                      _launchURL(
                          'https://www.youtube.com/channel/UCBLobRjSIpzWtA3Q64Uf4iA');

                      // Update the UI based on the item selected
                    },
                  ),

                  ListTile(
                    title: Text(StringsKeys.more.tr),
                    onTap: () {
                      // Update the UI based on the item selected
                    },
                  ),
                  LanguageDropdown(),
                  //  ThemeSwitcher()
                ],
              ),
            ),
            body: controller.transactions.isEmpty
                ? const ErrorScreen(
                    title: StringsKeys.youHaveNoTransactions,
                  )
                : ResponsiveView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.transactions.length,
                            itemBuilder: (_, i) {
                              return _buildTransactionItem(i);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        }
      },
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ColoredBox(
              color: Get.theme.primaryColor,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ColoredBox(
              color: Get.theme.scaffoldBackgroundColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Text(
        StringsKeys.recentActivity.tr,
        style: Get.textTheme.labelLarge,
      ),
    );
  }

  Widget _buildTransactionItem(final int i) {
    final transaction = controller.transactions[i];
    if (transaction != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Offstage(
            offstage: _checkDateSeparator(i),
            child: _buildDateSeparator(i),
          ),
          TransactionItem(
            item: transaction,
            onTap: controller.goTransaction,
          ),
          _bottomSeparator(
            i: i,
            j: controller.transactions.length,
          ),
        ],
      );
    } else {
      return SizedBox
          .shrink(); // Return an empty SizedBox if transaction is null
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildDateSeparator(final int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Text(
        getDateYT(controller.transactions[i].createdAt),
        style: Get.textTheme.labelSmall,
      ),
    );
  }

  bool _checkDateSeparator(final int i) {
    bool hideDate = false;
    if (i != controller.transactions.length &&
        i != 0 &&
        controller.transactions.isNotEmpty) {
      if (isTheSameDay(
        firstDate: controller.transactions[i - 1].createdAt,
        secondDate: controller.transactions[i].createdAt,
      )) {
        hideDate = true;
      }
    }
    return hideDate;
  }

  Widget _bottomSeparator({
    required final int i,
    required final int j,
  }) {
    return Offstage(
      offstage: i + 1 != j,
      child: const SafeArea(
        child: SizedBox(
          height: 8,
        ),
      ),
    );
  }



void _setImageAndSave(String? imagePath) {
  if (imagePath != null) {
    final imageFile = File(imagePath);
    _image = imageFile;
    _storage.write('image', imagePath); // Save image path to storage
  } else {
    print('No image selected.');
  }
}


// Function to show delete confirmation dialog
void _showDeleteConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(StringsKeys.deleteConfirmation.tr),
        content: Text(StringsKeys. areyousureyouwanttodelete.tr),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(StringsKeys.cancel.tr),
          ),
          TextButton(
            onPressed: () {
              // Perform delete action
              controller.dropData();
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(StringsKeys.delete.tr),
          ),
        ],
      );
    },
  );
}




  
// Function to handle tap events on the CircleAvatar


}

class LanguageDropdown extends StatelessWidget {
  final LocalStorage _languageController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Set the default language when the widget is initialized
    _languageController.loadLanguagePreference();

    return ListTile(
      leading: Icon(Icons.language), // Icon indicating language
      title: Text(
        StringsKeys.selectlanguage.tr,
        style: TextStyle(fontSize: 16.0),
      ), // Translate language
      trailing: DropdownButton<String>(
        value: _languageController
            .languageCode.value, // Get the current language code
        onChanged: (String? newLanguage) {
          if (newLanguage != null) {
            // Update the language when a new language is selected
            _languageController.saveLanguagePreference(newLanguage);
            Get.updateLocale(Locale(newLanguage));
          }
        },
        items: ['en', 'ar', 'fr'] // Ensure each value is unique
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value == 'en'
                  ? 'en'
                  : value == 'ar'
                      ? 'ar'
                      : 'fr',
              style: TextStyle(fontSize: 16.0),
            ), // Translate language names
          );
        }).toList(),
      ),
    );
  }
}

class ThemeSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Determine the icon based on the current theme
    IconData icon = Theme.of(context).brightness == Brightness.light
        ? Icons.nightlight_round // Display moon icon for light theme
        : Icons.wb_sunny; // Display sun icon for dark theme

    return ListTile(
      leading: Icon(icon), // Display the determined icon
      title: Text(
        'Switch Theme',
        style: TextStyle(fontSize: 16.0),
      ), // Text for the theme switch
      onTap: () {
        // Toggle between light and dark themes
        Get.changeTheme(
          Theme.of(context).brightness == Brightness.light
              ? ThemeData.dark()
              : ThemeData.light(),
        );
      },
    );
  }
}
