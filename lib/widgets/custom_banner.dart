import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customBanner(imageUrl) => SizedBox(
      width: 320.w,
      child: Card(
        // color: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding:  EdgeInsets.all(16.0.h),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              errorWidget: (context, url, error) {
                return Column(
                  children: [
                    const Icon(Icons.error_outline),
                     SizedBox(
                      height: 10.h,
                    ),
                    Text(error.toString())
                  ],
                );
              },
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ),
    );

Widget customShimmerBanner() => SizedBox(
  width: 320.w,
  child: Card(
    // color: Colors.transparent,
    elevation: 2,
    shadowColor: Colors.black12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding:  EdgeInsets.all(16.0.h),
        child: const SizedBox(),
      ),
    ),
  ),
);