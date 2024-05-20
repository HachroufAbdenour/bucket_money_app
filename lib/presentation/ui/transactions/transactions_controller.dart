import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/data/repositories/account_repository.dart';
import 'package:money_app/data/repositories/transactions_repository.dart';
import 'package:money_app/domain/models/account_model.dart';
import 'package:money_app/domain/models/transaction_model.dart';
import 'package:money_app/presentation/router/routes.dart';
import 'package:money_app/shared/enums/screen_enums.dart';
import 'package:money_app/shared/enums/transaction_enums.dart';

class TransactionsController extends GetxController {
  final LocalStorage _storage;

  final AccountRepository _accountRepository;
  final TransactionsRepository _transactionsRepository;

  var _image = Rx<File?>(null);
  
  File? get image => _image.value;
  
  void setImage(File? file) {
    _image.value = file;
  }
    Future<void> getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);
      setImage(image);
      GetStorage().write('image', pickedFile.path); // Save image path to storage
    } else {
      print('No image selected.');
    }
  }


final _storagee = GetStorage();
 // Define an observable variable to hold the path of the selected image
  RxString imagePath = ''.obs;


  TransactionsController(
    this._storage,
    this._accountRepository,
    this._transactionsRepository,
  );

  ScreenEnums _screenEnum = ScreenEnums.loaded;
  ScreenEnums get screenEnum => _screenEnum;
  set screenEnum(ScreenEnums v) {
    _screenEnum = v;
    update();
  }

  AccountModel? account;
  List<TransactionModel> transactions = <TransactionModel>[];

  @override
  void onInit() async {
    super.onInit();
      imagePath.value = _storagee.read('image') ?? '';
    screenEnum = ScreenEnums.loading;
    await Future.wait([
      getAccountData(),
      getTransactions(),
    ]);
    screenEnum = ScreenEnums.loaded;
    if (account == null) {
      screenEnum = ScreenEnums.error;
    }
  }

 // Function to set the selected image path
  void setImagePath(String newPath) {
    imagePath.value = newPath;
    _storagee.write('image', newPath); // Save image path to storage
  }

  Future<void> getAccountData() async {
    account = await _accountRepository.getAccountData();
  }

  Future<void> getTransactions() async {
    transactions = await _transactionsRepository.getTransactions();
  }

  void onTapPay() => goPay(TransactionsEnums.pay);

  void onTapTopUp() => goPay(TransactionsEnums.topUp);

  void goPay(final TransactionsEnums type) async {
    final res = await Get.toNamed(
      AppRoutes.pay,
      arguments: type,
    );
    if (res == ScreenEnums.refresh) {
      onInit();
    }
  }

  void goTransaction(final String? id) async {
    if (id != null) {
      final res = await Get.toNamed(
        AppRoutes.transactionDetails,
        arguments: id,
      );
      if (res == ScreenEnums.refresh) {
        onInit();
        
      }
    }
  }



  void deleteTransaction(String transactionId) {
              _storage.deleteTransaction(transactionId);  
              getTransactions();
              // Call the delete function from the controller
  update(); // This will trigger the UI update
}


  void dropData() async {
    await _storage.clearBox();
    onInit();
  }
}
