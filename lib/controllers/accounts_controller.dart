/*
import 'package:get/get.dart';
import 'package:task_api_implement/models/account_list_model.dart';
import 'package:task_api_implement/repositries/rest_api.dart';
class AccountController extends GetxController{

  Rx<AccountListModel> accountInfo = AccountListModel().obs;
  RxBool accountDataLoaded = false.obs;

  @override
  void onInit() {
    domains();
    super.onInit();
  }

  void domains() async{
     var account =await RestApiRepository().getAccounts();
     accountInfo.value=account;
     accountDataLoaded.value = true;
  }
}*/
