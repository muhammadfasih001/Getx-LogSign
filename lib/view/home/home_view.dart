import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task/components/color/appcolors.dart';
import 'package:task/controller/photo_controller.dart';
import 'package:task/controller/signOut_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeView extends StatelessWidget {
  final signOutController = Get.put(SignOutController());
  final photoController = Get.put(PhotoController());

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.homeBackColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColor.headColor,
          systemNavigationBarColor: AppColor.homeBackColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.headColor,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.elliptical(70, 70),
                          bottomLeft: Radius.elliptical(70, 70),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    // left: 20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              // APPLY BUTTON LOGIC
                            },
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          const SizedBox(width: 50),
                          Text(
                            "API CALL",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 45),
                          IconButton(
                            onPressed: () {
                              signOutController.signOut();
                            },
                            icon: const Icon(
                              Icons.logout_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(2, 10),
                              blurRadius: 15,
                              spreadRadius: -8,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.search,
                                color: Color(0xffEC9E98),
                                size: 30,
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search',
                                    hintStyle: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(
                  () => (photoController.photoModel.isEmpty)
                      ? Center(
                          child: LoadingAnimationWidget.flickr(
                            leftDotColor: AppColor.avatarColor,
                            rightDotColor: AppColor.headColor,
                            size: 80,
                          ),
                        )
                      : ListView.builder(
                          itemCount: photoController.photoModel.length,
                          itemBuilder: (context, index) {
                            final photo = photoController.photoModel[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                height: 160,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(10, 10),
                                      color: Colors.grey,
                                      spreadRadius: -7,
                                      blurRadius: 5,
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.elliptical(30, 30),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, top: 20),
                                          child: SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.network(photo.url!),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15,
                                                  left: 25,
                                                ),
                                                child: Text(
                                                  photo.title!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 25,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.person,
                                                      color: Color(0xffEC9E98),
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(
                                                      "ID : ${photo.id.toString()}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    Text(
                                                      "AID : ${photo.albumId.toString()}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15,
                                                  left: 25,
                                                ),
                                                child: SizedBox(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.network(
                                                      photo.thumbnailUrl!),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
