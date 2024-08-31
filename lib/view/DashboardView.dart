import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashboard_design/Constants/ColorThemes.dart';
import 'package:dashboard_design/Constants/ImageAssets.dart';
import 'package:dashboard_design/Constants/Infos.dart';
import 'package:dashboard_design/Responsive%20Widget/ResponsiveWidget.dart';
import 'package:dashboard_design/view/widgets/MembersListWidget.dart';
import 'package:dashboard_design/view/widgets/OverViewGraphWidget.dart';
import 'package:dashboard_design/view/widgets/PlatformCapacityGraph.dart';
import 'package:dashboard_design/view/widgets/StackDataWidget.dart';
import 'package:dashboard_design/view/widgets/VehicleSchedule.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int drawerIndex = 0;
  bool isLightMode = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveWidget(
        mobile: Container(
          color: Colors.black,
          height: size.height,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14).copyWith(bottom: 10),
                      child: Image.asset(
                        logo2,
                        height: 45,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 08, vertical: 04),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: whiteColor.withOpacity(0.08),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLightMode = false;
                              });
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: !isLightMode
                                  ? yellowColor
                                  : Colors.transparent,
                              child: const Icon(
                                Icons.dark_mode,
                                size: 18,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          const SizedBox(width: 06),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLightMode = true;
                              });
                            },
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: isLightMode
                                  ? yellowColor
                                  : Colors.transparent,
                              child: const Icon(
                                Icons.light_mode,
                                size: 18,
                                color: whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Image.asset(
                      email,
                      width: 20,
                      color: whiteColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset(
                        setting,
                        width: 20,
                        color: whiteColor,
                      ),
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          bellIcon,
                          width: 20,
                          color: whiteColor,
                        ),
                        const Positioned(
                          top: 0,
                          right: -4,
                          child: CircleAvatar(
                            radius: 08,
                            backgroundColor: red,
                            child: Text(
                              '3',
                              style: TextStyle(color: whiteColor, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundImage: AssetImage(profile1),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: ListTile(
                            title: Text(
                              'Dashboard',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: whiteColor,
                                      fontSize: 28,
                                      height: 2,
                                      fontWeight: FontWeight.w900),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                  text: 'Today\'s daily overview -  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: whiteColor.withOpacity(0.4)),
                                  children: [
                                    TextSpan(
                                      text: 'April 23, 2024',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: whiteColor),
                                    )
                                  ]),
                            ),
                            contentPadding: EdgeInsets.zero,
                            horizontalTitleGap: 12,
                          ),
                        ),
                        const SizedBox(height: 20),

                        /// stack data widget
                        const StackDataWidget(
                          axisCount: 2,
                          isMobile: true,
                        ),

                        const SizedBox(height: 22),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///over view graph
                              const OverViewGraphWidget(
                                isMobile: true,
                              ),
                              // const SizedBox(height: 18),
                              SizedBox(
                                  height: 250,
                                  width: size.width,
                                  child: const PlatformCapacityGraph()),

                              /// schedule vehicles
                              SizedBox(
                                height: 200,
                                width: size.width,
                                child: const Align(
                                    alignment: Alignment.topCenter,
                                    child: VehicleSchedule()),
                              ),
                              const SizedBox(height: 20),
                              const MembersListWidget(),
                              const SafeArea(child: SizedBox(height: 18))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        tablet: Row(
          children: [
            /// Drawer
            buildDrawerWidget(size, context, true),

            /// Screen
            Expanded(
              child: Container(
                color: Colors.black,
                height: size.height,
                child: Column(
                  children: [
                    /// top app bar
                    buildTopBar(context),
                    const Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 22),

                            /// stack data widget
                            StackDataWidget(axisCount: 2),
                            SizedBox(height: 22),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///over view graph
                                  OverViewGraphWidget(),
                                  SizedBox(height: 18),
                                  Row(
                                    children: [
                                      /// Platform Capacity Graph
                                      PlatformCapacityGraph(),
                                      SizedBox(width: 18),

                                      /// schedule vehicles
                                      VehicleSchedule(),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  MembersListWidget(isTablet: true),
                                  SafeArea(child: SizedBox(height: 18))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        desktop: Row(
          children: [
            /// Drawer
            buildDrawerWidget(size, context, false),

            /// Screen
            Expanded(
              child: Container(
                color: Colors.black,
                height: size.height,
                child: Column(
                  children: [
                    /// top app bar
                    buildTopBar(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 22),

                            /// stack data widget
                            const StackDataWidget(),

                            Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.amber.withOpacity(0.3),
                                  child:  const RiveAnimation.asset(
                                    'assets/liquid_download.riv',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.amber.withOpacity(0.3),
                                  child:  const RiveAnimation.asset(
                                    'assets/off_road_car.riv',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  color: Colors.amber.withOpacity(0.3),
                                  child:  const RiveAnimation.asset(
                                    'assets/vehicles.riv',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                CachedNetworkImage(imageUrl: "data:image/jpeg;base64,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"),
                                CachedNetworkImage(imageUrl: "data:image/jpeg;base64,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"),
                                CachedNetworkImage(imageUrl: "data:image/jpeg;base64,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"),
                                CachedNetworkImage(imageUrl: "data:image/jpeg;base64,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"),
                              ],
                            ),
                            const SizedBox(height: 22),
                            const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ///over view graph
                                        OverViewGraphWidget(),
                                        SizedBox(height: 18),
                                        Row(
                                          children: [
                                            /// Platform Capacity Graph
                                            PlatformCapacityGraph(),
                                            SizedBox(width: 18),

                                            /// schedule vehicles
                                            VehicleSchedule(),
                                          ],
                                        ),
                                        SafeArea(
                                            child: SizedBox(height: 18))
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                      flex: 2, child: MembersListWidget())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ListTile(
                title: Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: whiteColor,
                      fontSize: 28,
                      height: 2,
                      fontWeight: FontWeight.w900),
                ),
                subtitle: RichText(
                  text: TextSpan(
                      text: 'Today\'s daily overview -  ',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: whiteColor.withOpacity(0.4)),
                      children: [
                        TextSpan(
                          text: 'April 23, 2024',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: whiteColor),
                        )
                      ]),
                ),
                contentPadding: EdgeInsets.zero,
                horizontalTitleGap: 12,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 08, vertical: 04),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: whiteColor.withOpacity(0.08),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isLightMode = false;
                    });
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        !isLightMode ? yellowColor : Colors.transparent,
                    child: const Icon(
                      Icons.dark_mode,
                      size: 22,
                      color: whiteColor,
                    ),
                  ),
                ),
                const SizedBox(width: 08),
                InkWell(
                  onTap: () {
                    setState(() {
                      isLightMode = true;
                    });
                  },
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor:
                        isLightMode ? yellowColor : Colors.transparent,
                    child: const Icon(
                      Icons.light_mode,
                      size: 22,
                      color: whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Image.asset(
            email,
            width: 24,
            color: whiteColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              setting,
              width: 24,
              color: whiteColor,
            ),
          ),
          Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                bellIcon,
                width: 24,
                color: whiteColor,
              ),
              const Positioned(
                top: 0,
                right: -4,
                child: CircleAvatar(
                  radius: 09,
                  backgroundColor: red,
                  child: Text(
                    '3',
                    style: TextStyle(color: whiteColor, fontSize: 12),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 20),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(profile1),
            ),
          )
        ],
      ),
    );
  }

  AnimatedContainer buildDrawerWidget(
    Size size,
    BuildContext context,
    bool isTablet,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isTablet ? 70 : 200,
      height: size.height,
      color: Colors.black87,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: isTablet
                  ? const EdgeInsets.all(14).copyWith(bottom: 20)
                  : const EdgeInsets.only(top: 12, bottom: 35),
              child: Image.asset(
                isTablet ? logo1 : logo2,
                height: 60,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                var item = drawerList[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      drawerIndex = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 14),
                    child: Row(
                      children: [
                        Image.asset(
                          item['image'],
                          width: 22,
                          color:
                              drawerIndex == index ? yellowColor : whiteColor,
                        ),
                        if (!isTablet) const SizedBox(width: 16),
                        if (!isTablet)
                          Text(
                            item['title'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: drawerIndex == index
                                        ? yellowColor
                                        : whiteColor),
                          ),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          height: drawerIndex == index ? 30 : 0,
                          width: drawerIndex == index ? 2 : 0,
                          color: yellowColor,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            Container(
              color: Colors.white.withOpacity(0.08),
              height: isTablet ? 26 : 60,
              padding: const EdgeInsets.only(left: 16),
              width: double.infinity,
              child: isTablet
                  ? Image.asset(
                      logOut,
                      width: 22,
                      color: whiteColor,
                    )
                  : Row(
                      children: [
                        Image.asset(
                          logOut,
                          width: 22,
                          color: whiteColor,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          'Logout',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: whiteColor),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
