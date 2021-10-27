import 'package:bazaar_bihar/shared/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';

class WalletHome extends StatelessWidget {
  const WalletHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Container(
        height: Get.mediaQuery.size.height,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 16, left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Balance",
                                style: Get.theme.textTheme.headline6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(rupeeSymbol,
                                    style: Get.theme.textTheme.headline4),
                                Text("200",
                                    style: Get.theme.textTheme.headline4),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Reward coins ",
                                style: Get.theme.textTheme.headline6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    FontAwesome5Solid.coins,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Text("200",
                                    style: Get.theme.textTheme.headline4),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: Text(
                "Transactions",
                style: Get.theme.textTheme.headline5,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                      50,
                      (index) =>
                          ListTile(title: Text("Transactions ${index + 1}"))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
