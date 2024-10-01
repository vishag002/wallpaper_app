// To parse this JSON data, do
//
//     final collectionClass = collectionClassFromJson(jsonString);

import 'dart:convert';

List<CollectionClass> collectionClassFromJson(String str) =>
    List<CollectionClass>.from(
        json.decode(str).map((x) => CollectionClass.fromJson(x)));

String collectionClassToJson(List<CollectionClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CollectionClass {
  String? id;
  String? title;
  String? description;
  DateTime? publishedAt;
  DateTime? lastCollectedAt;
  DateTime? updatedAt;
  bool? featured;
  int? totalPhotos;
  bool? private;
  String? shareKey;
  List<Tag>? tags;
  CollectionClassLinks? links;
  User? user;
  CollectionClassCoverPhoto? coverPhoto;
  List<PreviewPhoto>? previewPhotos;

  CollectionClass({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.tags,
    this.links,
    this.user,
    this.coverPhoto,
    this.previewPhotos,
  });

  factory CollectionClass.fromJson(Map<String, dynamic> json) =>
      CollectionClass(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        lastCollectedAt: json["last_collected_at"] == null
            ? null
            : DateTime.parse(json["last_collected_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        featured: json["featured"],
        totalPhotos: json["total_photos"],
        private: json["private"],
        shareKey: json["share_key"],
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        links: json["links"] == null
            ? null
            : CollectionClassLinks.fromJson(json["links"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        coverPhoto: json["cover_photo"] == null
            ? null
            : CollectionClassCoverPhoto.fromJson(json["cover_photo"]),
        previewPhotos: json["preview_photos"] == null
            ? []
            : List<PreviewPhoto>.from(
                json["preview_photos"]!.map((x) => PreviewPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "published_at": publishedAt?.toIso8601String(),
        "last_collected_at": lastCollectedAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "featured": featured,
        "total_photos": totalPhotos,
        "private": private,
        "share_key": shareKey,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "user": user?.toJson(),
        "cover_photo": coverPhoto?.toJson(),
        "preview_photos": previewPhotos == null
            ? []
            : List<dynamic>.from(previewPhotos!.map((x) => x.toJson())),
      };
}

class CollectionClassCoverPhoto {
  String? id;
  String? slug;
  AlternativeSlugs? alternativeSlugs;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  List<dynamic>? breadcrumbs;
  Urls? urls;
  CoverPhotoLinks? links;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  PurpleTopicSubmissions? topicSubmissions;
  AssetType? assetType;
  User? user;

  CollectionClassCoverPhoto({
    this.id,
    this.slug,
    this.alternativeSlugs,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.breadcrumbs,
    this.urls,
    this.links,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.assetType,
    this.user,
  });

  factory CollectionClassCoverPhoto.fromJson(Map<String, dynamic> json) =>
      CollectionClassCoverPhoto(
        id: json["id"],
        slug: json["slug"],
        alternativeSlugs: json["alternative_slugs"] == null
            ? null
            : AlternativeSlugs.fromJson(json["alternative_slugs"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        description: json["description"],
        altDescription: json["alt_description"],
        breadcrumbs: json["breadcrumbs"] == null
            ? []
            : List<dynamic>.from(json["breadcrumbs"]!.map((x) => x)),
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : CoverPhotoLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections: json["current_user_collections"] == null
            ? []
            : List<dynamic>.from(
                json["current_user_collections"]!.map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: json["topic_submissions"] == null
            ? null
            : PurpleTopicSubmissions.fromJson(json["topic_submissions"]),
        assetType: assetTypeValues.map[json["asset_type"]]!,
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "alternative_slugs": alternativeSlugs?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "description": description,
        "alt_description": altDescription,
        "breadcrumbs": breadcrumbs == null
            ? []
            : List<dynamic>.from(breadcrumbs!.map((x) => x)),
        "urls": urls?.toJson(),
        "links": links?.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections": currentUserCollections == null
            ? []
            : List<dynamic>.from(currentUserCollections!.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions?.toJson(),
        "asset_type": assetTypeValues.reverse[assetType],
        "user": user?.toJson(),
      };
}

class AlternativeSlugs {
  String? en;
  String? es;
  String? ja;
  String? fr;
  String? it;
  String? ko;
  String? de;
  String? pt;

  AlternativeSlugs({
    this.en,
    this.es,
    this.ja,
    this.fr,
    this.it,
    this.ko,
    this.de,
    this.pt,
  });

  factory AlternativeSlugs.fromJson(Map<String, dynamic> json) =>
      AlternativeSlugs(
        en: json["en"],
        es: json["es"],
        ja: json["ja"],
        fr: json["fr"],
        it: json["it"],
        ko: json["ko"],
        de: json["de"],
        pt: json["pt"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "es": es,
        "ja": ja,
        "fr": fr,
        "it": it,
        "ko": ko,
        "de": de,
        "pt": pt,
      };
}

enum AssetType { PHOTO }

final assetTypeValues = EnumValues({"photo": AssetType.PHOTO});

class CoverPhotoLinks {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  CoverPhotoLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory CoverPhotoLinks.fromJson(Map<String, dynamic> json) =>
      CoverPhotoLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
      };
}

class PurpleTopicSubmissions {
  Nature? wallpapers;
  Travel? travel;
  Nature? nature;
  Nature? texturesPatterns;

  PurpleTopicSubmissions({
    this.wallpapers,
    this.travel,
    this.nature,
    this.texturesPatterns,
  });

  factory PurpleTopicSubmissions.fromJson(Map<String, dynamic> json) =>
      PurpleTopicSubmissions(
        wallpapers: json["wallpapers"] == null
            ? null
            : Nature.fromJson(json["wallpapers"]),
        travel: json["travel"] == null ? null : Travel.fromJson(json["travel"]),
        nature: json["nature"] == null ? null : Nature.fromJson(json["nature"]),
        texturesPatterns: json["textures-patterns"] == null
            ? null
            : Nature.fromJson(json["textures-patterns"]),
      );

  Map<String, dynamic> toJson() => {
        "wallpapers": wallpapers?.toJson(),
        "travel": travel?.toJson(),
        "nature": nature?.toJson(),
        "textures-patterns": texturesPatterns?.toJson(),
      };
}

class Nature {
  Status? status;
  DateTime? approvedOn;

  Nature({
    this.status,
    this.approvedOn,
  });

  factory Nature.fromJson(Map<String, dynamic> json) => Nature(
        status: statusValues.map[json["status"]]!,
        approvedOn: json["approved_on"] == null
            ? null
            : DateTime.parse(json["approved_on"]),
      );

  Map<String, dynamic> toJson() => {
        "status": statusValues.reverse[status],
        "approved_on": approvedOn?.toIso8601String(),
      };
}

enum Status { APPROVED }

final statusValues = EnumValues({"approved": Status.APPROVED});

class Travel {
  String? status;

  Travel({
    this.status,
  });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}

class User {
  String? id;
  DateTime? updatedAt;
  String? username;
  String? name;
  String? firstName;
  String? lastName;
  String? twitterUsername;
  String? portfolioUrl;
  String? bio;
  String? location;
  UserLinks? links;
  ProfileImage? profileImage;
  String? instagramUsername;
  int? totalCollections;
  int? totalLikes;
  int? totalPhotos;
  int? totalPromotedPhotos;
  int? totalIllustrations;
  int? totalPromotedIllustrations;
  bool? acceptedTos;
  bool? forHire;
  Social? social;

  User({
    this.id,
    this.updatedAt,
    this.username,
    this.name,
    this.firstName,
    this.lastName,
    this.twitterUsername,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.links,
    this.profileImage,
    this.instagramUsername,
    this.totalCollections,
    this.totalLikes,
    this.totalPhotos,
    this.totalPromotedPhotos,
    this.totalIllustrations,
    this.totalPromotedIllustrations,
    this.acceptedTos,
    this.forHire,
    this.social,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        username: json["username"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        twitterUsername: json["twitter_username"],
        portfolioUrl: json["portfolio_url"],
        bio: json["bio"],
        location: json["location"],
        links: json["links"] == null ? null : UserLinks.fromJson(json["links"]),
        profileImage: json["profile_image"] == null
            ? null
            : ProfileImage.fromJson(json["profile_image"]),
        instagramUsername: json["instagram_username"],
        totalCollections: json["total_collections"],
        totalLikes: json["total_likes"],
        totalPhotos: json["total_photos"],
        totalPromotedPhotos: json["total_promoted_photos"],
        totalIllustrations: json["total_illustrations"],
        totalPromotedIllustrations: json["total_promoted_illustrations"],
        acceptedTos: json["accepted_tos"],
        forHire: json["for_hire"],
        social: json["social"] == null ? null : Social.fromJson(json["social"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_at": updatedAt?.toIso8601String(),
        "username": username,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "twitter_username": twitterUsername,
        "portfolio_url": portfolioUrl,
        "bio": bio,
        "location": location,
        "links": links?.toJson(),
        "profile_image": profileImage?.toJson(),
        "instagram_username": instagramUsername,
        "total_collections": totalCollections,
        "total_likes": totalLikes,
        "total_photos": totalPhotos,
        "total_promoted_photos": totalPromotedPhotos,
        "total_illustrations": totalIllustrations,
        "total_promoted_illustrations": totalPromotedIllustrations,
        "accepted_tos": acceptedTos,
        "for_hire": forHire,
        "social": social?.toJson(),
      };
}

class UserLinks {
  String? self;
  String? html;
  String? photos;
  String? likes;
  String? portfolio;
  String? following;
  String? followers;

  UserLinks({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
    this.following,
    this.followers,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) => UserLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        likes: json["likes"],
        portfolio: json["portfolio"],
        following: json["following"],
        followers: json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "likes": likes,
        "portfolio": portfolio,
        "following": following,
        "followers": followers,
      };
}

class ProfileImage {
  String? small;
  String? medium;
  String? large;

  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "small": small,
        "medium": medium,
        "large": large,
      };
}

class Social {
  String? instagramUsername;
  String? portfolioUrl;
  String? twitterUsername;
  dynamic paypalEmail;

  Social({
    this.instagramUsername,
    this.portfolioUrl,
    this.twitterUsername,
    this.paypalEmail,
  });

  factory Social.fromJson(Map<String, dynamic> json) => Social(
        instagramUsername: json["instagram_username"],
        portfolioUrl: json["portfolio_url"],
        twitterUsername: json["twitter_username"],
        paypalEmail: json["paypal_email"],
      );

  Map<String, dynamic> toJson() => {
        "instagram_username": instagramUsername,
        "portfolio_url": portfolioUrl,
        "twitter_username": twitterUsername,
        "paypal_email": paypalEmail,
      };
}

class CollectionClassLinks {
  String? self;
  String? html;
  String? photos;
  String? related;

  CollectionClassLinks({
    this.self,
    this.html,
    this.photos,
    this.related,
  });

  factory CollectionClassLinks.fromJson(Map<String, dynamic> json) =>
      CollectionClassLinks(
        self: json["self"],
        html: json["html"],
        photos: json["photos"],
        related: json["related"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "photos": photos,
        "related": related,
      };
}

class PreviewPhoto {
  String? id;
  String? slug;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? blurHash;
  AssetType? assetType;
  Urls? urls;

  PreviewPhoto({
    this.id,
    this.slug,
    this.createdAt,
    this.updatedAt,
    this.blurHash,
    this.assetType,
    this.urls,
  });

  factory PreviewPhoto.fromJson(Map<String, dynamic> json) => PreviewPhoto(
        id: json["id"],
        slug: json["slug"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        blurHash: json["blur_hash"],
        assetType: assetTypeValues.map[json["asset_type"]]!,
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "blur_hash": blurHash,
        "asset_type": assetTypeValues.reverse[assetType],
        "urls": urls?.toJson(),
      };
}

class Tag {
  Type? type;
  String? title;
  Source? source;

  Tag({
    this.type,
    this.title,
    this.source,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        type: typeValues.map[json["type"]]!,
        title: json["title"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "type": typeValues.reverse[type],
        "title": title,
        "source": source?.toJson(),
      };
}

class Source {
  Ancestry? ancestry;
  String? title;
  String? subtitle;
  String? description;
  String? metaTitle;
  String? metaDescription;
  SourceCoverPhoto? coverPhoto;
  dynamic affiliateSearchQuery;

  Source({
    this.ancestry,
    this.title,
    this.subtitle,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.coverPhoto,
    this.affiliateSearchQuery,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        ancestry: json["ancestry"] == null
            ? null
            : Ancestry.fromJson(json["ancestry"]),
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        coverPhoto: json["cover_photo"] == null
            ? null
            : SourceCoverPhoto.fromJson(json["cover_photo"]),
        affiliateSearchQuery: json["affiliate_search_query"],
      );

  Map<String, dynamic> toJson() => {
        "ancestry": ancestry?.toJson(),
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "cover_photo": coverPhoto?.toJson(),
        "affiliate_search_query": affiliateSearchQuery,
      };
}

class Ancestry {
  Category? type;
  Category? category;
  Category? subcategory;

  Ancestry({
    this.type,
    this.category,
    this.subcategory,
  });

  factory Ancestry.fromJson(Map<String, dynamic> json) => Ancestry(
        type: json["type"] == null ? null : Category.fromJson(json["type"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null
            ? null
            : Category.fromJson(json["subcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type?.toJson(),
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
      };
}

class Category {
  String? slug;
  String? prettySlug;

  Category({
    this.slug,
    this.prettySlug,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        slug: json["slug"],
        prettySlug: json["pretty_slug"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "pretty_slug": prettySlug,
      };
}

class SourceCoverPhoto {
  String? id;
  String? slug;
  AlternativeSlugs? alternativeSlugs;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  List<Breadcrumb>? breadcrumbs;
  Urls? urls;
  CoverPhotoLinks? links;
  int? likes;
  bool? likedByUser;
  List<dynamic>? currentUserCollections;
  dynamic sponsorship;
  FluffyTopicSubmissions? topicSubmissions;
  AssetType? assetType;
  bool? premium;
  bool? plus;
  User? user;

  SourceCoverPhoto({
    this.id,
    this.slug,
    this.alternativeSlugs,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.width,
    this.height,
    this.color,
    this.blurHash,
    this.description,
    this.altDescription,
    this.breadcrumbs,
    this.urls,
    this.links,
    this.likes,
    this.likedByUser,
    this.currentUserCollections,
    this.sponsorship,
    this.topicSubmissions,
    this.assetType,
    this.premium,
    this.plus,
    this.user,
  });

  factory SourceCoverPhoto.fromJson(Map<String, dynamic> json) =>
      SourceCoverPhoto(
        id: json["id"],
        slug: json["slug"],
        alternativeSlugs: json["alternative_slugs"] == null
            ? null
            : AlternativeSlugs.fromJson(json["alternative_slugs"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        width: json["width"],
        height: json["height"],
        color: json["color"],
        blurHash: json["blur_hash"],
        description: json["description"],
        altDescription: json["alt_description"],
        breadcrumbs: json["breadcrumbs"] == null
            ? []
            : List<Breadcrumb>.from(
                json["breadcrumbs"]!.map((x) => Breadcrumb.fromJson(x))),
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : CoverPhotoLinks.fromJson(json["links"]),
        likes: json["likes"],
        likedByUser: json["liked_by_user"],
        currentUserCollections: json["current_user_collections"] == null
            ? []
            : List<dynamic>.from(
                json["current_user_collections"]!.map((x) => x)),
        sponsorship: json["sponsorship"],
        topicSubmissions: json["topic_submissions"] == null
            ? null
            : FluffyTopicSubmissions.fromJson(json["topic_submissions"]),
        assetType: assetTypeValues.map[json["asset_type"]]!,
        premium: json["premium"],
        plus: json["plus"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "alternative_slugs": alternativeSlugs?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "width": width,
        "height": height,
        "color": color,
        "blur_hash": blurHash,
        "description": description,
        "alt_description": altDescription,
        "breadcrumbs": breadcrumbs == null
            ? []
            : List<dynamic>.from(breadcrumbs!.map((x) => x.toJson())),
        "urls": urls?.toJson(),
        "links": links?.toJson(),
        "likes": likes,
        "liked_by_user": likedByUser,
        "current_user_collections": currentUserCollections == null
            ? []
            : List<dynamic>.from(currentUserCollections!.map((x) => x)),
        "sponsorship": sponsorship,
        "topic_submissions": topicSubmissions?.toJson(),
        "asset_type": assetTypeValues.reverse[assetType],
        "premium": premium,
        "plus": plus,
        "user": user?.toJson(),
      };
}

class Breadcrumb {
  String? slug;
  String? title;
  int? index;
  Type? type;

  Breadcrumb({
    this.slug,
    this.title,
    this.index,
    this.type,
  });

  factory Breadcrumb.fromJson(Map<String, dynamic> json) => Breadcrumb(
        slug: json["slug"],
        title: json["title"],
        index: json["index"],
        type: typeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "title": title,
        "index": index,
        "type": typeValues.reverse[type],
      };
}

enum Type { LANDING_PAGE, SEARCH }

final typeValues =
    EnumValues({"landing_page": Type.LANDING_PAGE, "search": Type.SEARCH});

class FluffyTopicSubmissions {
  Nature? architectureInterior;
  Nature? colorOfWater;
  Nature? wallpapers;
  Nature? nature;
  Nature? currentEvents;
  Nature? texturesPatterns;

  FluffyTopicSubmissions({
    this.architectureInterior,
    this.colorOfWater,
    this.wallpapers,
    this.nature,
    this.currentEvents,
    this.texturesPatterns,
  });

  factory FluffyTopicSubmissions.fromJson(Map<String, dynamic> json) =>
      FluffyTopicSubmissions(
        architectureInterior: json["architecture-interior"] == null
            ? null
            : Nature.fromJson(json["architecture-interior"]),
        colorOfWater: json["color-of-water"] == null
            ? null
            : Nature.fromJson(json["color-of-water"]),
        wallpapers: json["wallpapers"] == null
            ? null
            : Nature.fromJson(json["wallpapers"]),
        nature: json["nature"] == null ? null : Nature.fromJson(json["nature"]),
        currentEvents: json["current-events"] == null
            ? null
            : Nature.fromJson(json["current-events"]),
        texturesPatterns: json["textures-patterns"] == null
            ? null
            : Nature.fromJson(json["textures-patterns"]),
      );

  Map<String, dynamic> toJson() => {
        "architecture-interior": architectureInterior?.toJson(),
        "color-of-water": colorOfWater?.toJson(),
        "wallpapers": wallpapers?.toJson(),
        "nature": nature?.toJson(),
        "current-events": currentEvents?.toJson(),
        "textures-patterns": texturesPatterns?.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
