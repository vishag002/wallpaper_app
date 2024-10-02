// To parse this JSON data, do
import 'dart:convert';

List<CollectionClass> collectionClassFromJson(String str) {
  final List<dynamic> jsonList = json.decode(str);
  return jsonList.map((x) => CollectionClass.fromJson(x)).toList();
}

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

  factory CollectionClass.fromJson(Map<String, dynamic> json) {
    return CollectionClass(
      id: json["id"]?.toString(),
      title: json["title"]?.toString(),
      description: json["description"]?.toString(),
      publishedAt: json["published_at"] == null
          ? null
          : DateTime.tryParse(json["published_at"].toString()),
      lastCollectedAt: json["last_collected_at"] == null
          ? null
          : DateTime.tryParse(json["last_collected_at"].toString()),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.tryParse(json["updated_at"].toString()),
      featured: json["featured"] == null ? null : json["featured"] as bool,
      totalPhotos:
          json["total_photos"] == null ? null : json["total_photos"] as int,
      private: json["private"] == null ? null : json["private"] as bool,
      shareKey: json["share_key"]?.toString(),
      tags: json["tags"] == null
          ? []
          : List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
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
              json["preview_photos"].map((x) => PreviewPhoto.fromJson(x))),
    );
  }
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
}

class Tag {
  Type? type;
  String? title;

  Tag({
    this.type,
    this.title,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        type: json["type"] == null
            ? null
            : typeValues.map[json["type"].toString()],
        title: json["title"]?.toString(),
      );
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
