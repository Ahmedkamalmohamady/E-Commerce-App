import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

Widget customBanner(imageUrl) => SizedBox(
      width: 320,
      child: Card(
        // color: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: imageUrl,
              errorWidget: (context, url, error) {
                return Column(
                  children: [
                    const Icon(Icons.error_outline),
                    const SizedBox(
                      height: 10,
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
