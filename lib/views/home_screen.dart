import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_api_implement/bd_helpers/local_store_token.dart';

import 'authentication/login_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: _buildDrawer(),
          appBar: AppBar(
            title: Text('Domains'),
          ),
          body: Text('Home Screen')
          /*  Obx(() {
          if (_domainController.domainDataLoaded.value == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_domainController.domainList.isEmpty &&
              _domainController.domainDataLoaded.value == true) {
            return Center(child: Text('No Found Data'));
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: _domainController.domainList.length,
                itemBuilder: (context, index) {
                  HydraMember domain = _domainController.domainList[index];
                  return buildDomainUI(domain);
                });
          }
        }),*/
          ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Stack(
              children: [
                Positioned(
                  bottom: 8.0,
                  left: 4.0,
                  child: Text(
                    "User Address ",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image: NetworkImage(
                  "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text("Account List"),
            onTap: () {
              //Get.to(AccountScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Message List"),
            onTap: () {
              //Get.to(MessageScreen());
            },
          ),
          LocalStoreToken.object.getToken() == null
              ? ListTile(
                  leading: Icon(Icons.login),
                  title: Text("Login/Register"),
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                )
              : ListTile(
                  leading: Icon(Icons.lock),
                  title: Text("Logout"),
                  onTap: () {
                    Get.offAll(LoginPageBody());
                  },
                ),
        ],
      ),
    );
  }
}
