import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:digital_management_sysem/index.dart';
import 'package:flutter/services.dart';

import '../selected_box/box_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class TypeSelectWidget extends StatefulWidget {
  final String project;

  const TypeSelectWidget({Key key, this.project}) : super(key: key);

  @override
  _TypeSelectWidgetState createState() => _TypeSelectWidgetState();
}

class _TypeSelectWidgetState extends State<TypeSelectWidget> {
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF190B99),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageWidget(),
              ),
            );
          },
        ),
        title: Text(
          "Type Select",
          style: FlutterFlowTheme
              .of(context)
              .title2
              .override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Color(0xFCFFFFFF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, -0.05),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Text(
                                'Description',
                                style: FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xF9FFFFFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Card(
                              elevation: 5,
                              child: ListTile(
                                onTap: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => MyJobsWidget()));
                                },
                                leading: Icon(
                                  Icons.access_time,
                                  size: 32,
                                ),
                                title: Text(
                                  'Prepping',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  size: 32,
                                ),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(
                                  Icons.inventory,
                                  size: 32,
                                ),
                                title: Text(
                                  'Inventory',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  size: 32,
                                ),
                              ), //       subtitle: Text(
                              //         'Unprepped',
                              //         style: FlutterFlowTheme.of(context)
                              //             .bodyText2
                              //             .override(
                              //               fontFamily: 'Poppins',
                              //               fontSize: 13,
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //       ),
                              //       trailing: Icon(
                              //         Icons.arrow_forward_ios,
                              //         color: Color(0xFF303030),
                              //         size: 20,
                              //       ),
                              //       tileColor: Color(0xFFF5F5F5),
                              //       dense: false,
                              //     ),
                              //   ),
                            ), Card(
                              elevation: 5,
                              child: ListTile(
                                leading: Icon(
                                  Icons.delivery_dining,
                                  size: 32,
                                ),
                                title: Text(
                                  'Logistics',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  size: 32,
                                ),
                              ), //       subtitle: Text(
                              //         'Unprepped',
                              //         style: FlutterFlowTheme.of(context)
                              //             .bodyText2
                              //             .override(
                              //               fontFamily: 'Poppins',
                              //               fontSize: 13,
                              //               fontWeight: FontWeight.w500,
                              //             ),
                              //       ),
                              //       trailing: Icon(
                              //         Icons.arrow_forward_ios,
                              //         color: Color(0xFF303030),
                              //         size: 20,
                              //       ),
                              //       tileColor: Color(0xFFF5F5F5),
                              //       dense: false,
                              //     ),
                              //   ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
