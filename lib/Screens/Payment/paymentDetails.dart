// ignore_for_file: depend_on_referenced_packages, file_names, prefer_is_empty
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hookup4u/util/color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class PaymentDetails extends StatelessWidget {
  final List<PurchaseDetails> purchases;
  const PaymentDetails(this.purchases, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text("Subscription details".tr().toString()),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: primaryColor,
        body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(38.0),
                        child: Text("Payment Summary:".tr().toString(),
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 23)),
                      ),
                    ]),
                    purchases.length > 0
                        ? ListView(
                            scrollDirection: Axis.vertical,
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            children: purchases.map((index) {
                              index as GooglePlayPurchaseDetails;
                              if (Platform.isIOS) {
                                index as AppStorePurchaseDetails;
                              }
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                          label: Text(
                                        "Plan".tr().toString(),
                                        style: const TextStyle(
                                          //   color: primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                      DataColumn(
                                          label: Text("Details".tr().toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                // color: primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ))),
                                    ],
                                    rows: [
                                      DataRow(cells: [
                                        const DataCell(Text("Transaction_id",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ))),
                                        DataCell(Text("${index.purchaseID}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ))),
                                      ]),
                                      DataRow(cells: [
                                        const DataCell(Text("product_id",
                                            style: TextStyle(
                                              fontSize: 15,
                                            ))),
                                        DataCell(Text(index.productID,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // color: primaryColor,
                                            ))),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text(
                                            "Subscribed on".tr().toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ))),
                                        DataCell(Text(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                    int.parse(
                                                        index.transactionDate!))
                                                .toLocal()
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              // color: primaryColor,
                                            ))),
                                      ]),
                                      DataRow(cells: [
                                        DataCell(Text("Status".tr().toString(),
                                            style: const TextStyle(
                                              fontSize: 15,
                                            ))),
                                        DataCell(Text(
                                            index.billingClientPurchase
                                                    .isAutoRenewing
                                                ? "Active".tr().toString()
                                                : "Cancelled".tr().toString(),
                                            style: TextStyle(
                                              color: index.billingClientPurchase
                                                      .isAutoRenewing
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 15,
                                            ))),
                                      ]),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      height: 60,
                      width: 250,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Card(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            "Back".tr().toString(),
                            style: const TextStyle(
                                fontSize: 17, color: Colors.white),
                          )),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
