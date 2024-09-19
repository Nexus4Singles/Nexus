import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/colors.dart';
import '../../../../core/style.dart';
import '../../controllers/matches_ctr.dart';

class MatchStats extends StatelessWidget {
  MatchStats({super.key});

  final ctr = Get.put(MatchesCtr());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  ctr.setMyLikes();
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(.3),
                    border: Border.all(
                      color: primary,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      opacity: .2,
                      image: AssetImage(
                        'assets/images/user1.png',
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: white,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'My Likes ',
                    style: textStyle16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      ctr.ctr.myProfile.value.myLikes == null
                          ? "0"
                          : '${ctr.ctr.allUsers.where((user) => ctr.ctr.myProfile.value.myLikes!.contains(user.id)).toList().length}',
                      style: textStyle16.copyWith(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  ctr.setLikedMe();
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(.3),
                    border: Border.all(
                      color: primary,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      opacity: .2,
                      image: AssetImage(
                        'assets/images/user1.png',
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: primary,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Liked Me ',
                    style: textStyle16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      ctr.ctr.myProfile.value.likeMe == null
                          ? "0"
                          : '${ctr.ctr.allUsers.where((user) => ctr.ctr.myProfile.value.likeMe!.contains(user.id)).toList().length}',
                      style: textStyle16.copyWith(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: () {
                  ctr.setSaved();
                },
                child: Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: primary.withOpacity(.3),
                    border: Border.all(
                      color: primary,
                      width: 2,
                    ),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      opacity: .2,
                      image: AssetImage(
                        'assets/images/user1.png',
                      ),
                    ),
                  ),
                  child: const Icon(
                    Icons.bookmark,
                    color: white,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Saved ',
                    style: textStyle16,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      ctr.ctr.myProfile.value.mySaves == null
                          ? "0"
                          : '${ctr.ctr.allUsers.where((user) => ctr.ctr.myProfile.value.mySaves!.contains(user.id)).toList().length}',
                      style: textStyle16.copyWith(
                        color: white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
