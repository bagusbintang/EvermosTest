import 'package:evermos_test1/module/dashboard/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (DashboardController controller) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: Get.height * .2,
                  backgroundColor: Colors.yellowAccent,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: const Text(
                      "Awesome App",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    background: Image.network(
                      "https://images.pexels.com/photos/4148020/pexels-photo-4148020.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ];
            },
            body: RefreshIndicator(
              onRefresh: () async {
                controller.getData();
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) =>
                    _onScrollNotification(notification, controller),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.changeView(true);
                                },
                                icon: const Icon(Icons.grid_view)),
                            IconButton(
                              onPressed: () {
                                controller.changeView(false);
                              },
                              icon: const Icon(Icons.list),
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () {
                          if (controller.isGridView.value) {
                            return gridviewPhoto(controller);
                          }
                          return listviewListPhoto(controller);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget gridviewPhoto(DashboardController controller) {
    return Obx(
      () {
        if (controller.dashboardLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(8),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.listPhoto
                  .map(
                    (itemPhoto) => Container(
                      width: 300,
                      height: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Image.network(
                        itemPhoto.src?.large ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (controller.loadmoreLoading.value)
              const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
    );
  }

  Widget listviewListPhoto(DashboardController controller) {
    return Obx(
      () {
        if (controller.dashboardLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.listPhoto.length,
              itemBuilder: (context, index) {
                var photoItem = controller.listPhoto[index];

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        photoItem.src?.original ?? '',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          photoItem.alt ?? '',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (controller.loadmoreLoading.value)
              const SizedBox(
                height: 300,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
          ],
        );
      },
    );
  }

  bool _onScrollNotification(
      ScrollNotification notif, DashboardController controller) {
    controller.scrollCondition(notif);

    return false;
  }
}
