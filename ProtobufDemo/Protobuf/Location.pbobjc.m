// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: Location.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers_RuntimeSupport.h>
#else
 #import "GPBProtocolBuffers_RuntimeSupport.h"
#endif

#import "Location.pbobjc.h"
// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

#pragma mark - LocationRoot

@implementation LocationRoot

// No extensions in the file and no imports, so no need to generate
// +extensionRegistry.

@end

#pragma mark - LocationRoot_FileDescriptor

static GPBFileDescriptor *LocationRoot_FileDescriptor(void) {
  // This is called by +initialize so there is no need to worry
  // about thread safety of the singleton.
  static GPBFileDescriptor *descriptor = NULL;
  if (!descriptor) {
    GPB_DEBUG_CHECK_RUNTIME_VERSIONS();
    descriptor = [[GPBFileDescriptor alloc] initWithPackage:@""
                                                     syntax:GPBFileSyntaxProto3];
  }
  return descriptor;
}

#pragma mark - Location

@implementation Location

@dynamic accessToken;
@dynamic cdType;
@dynamic clientId;
@dynamic connectUser;
@dynamic direction;
@dynamic latitude;
@dynamic longitude;
@dynamic orderId;
@dynamic speed;
@dynamic timestamp;
@dynamic travelMile;
@dynamic type;

typedef struct Location__storage_ {
  uint32_t _has_storage_[1];
  float speed;
  float travelMile;
  NSString *accessToken;
  NSString *cdType;
  NSString *clientId;
  NSString *connectUser;
  NSString *direction;
  NSString *orderId;
  NSString *type;
  double latitude;
  double longitude;
  int64_t timestamp;
} Location__storage_;

// This method is threadsafe because it is initially called
// in +initialize for each subclass.
+ (GPBDescriptor *)descriptor {
  static GPBDescriptor *descriptor = nil;
  if (!descriptor) {
    static GPBMessageFieldDescription fields[] = {
      {
        .name = "accessToken",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_AccessToken,
        .hasIndex = 0,
        .offset = (uint32_t)offsetof(Location__storage_, accessToken),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "cdType",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_CdType,
        .hasIndex = 1,
        .offset = (uint32_t)offsetof(Location__storage_, cdType),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "clientId",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_ClientId,
        .hasIndex = 2,
        .offset = (uint32_t)offsetof(Location__storage_, clientId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "connectUser",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_ConnectUser,
        .hasIndex = 3,
        .offset = (uint32_t)offsetof(Location__storage_, connectUser),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "direction",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Direction,
        .hasIndex = 4,
        .offset = (uint32_t)offsetof(Location__storage_, direction),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
      {
        .name = "latitude",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Latitude,
        .hasIndex = 5,
        .offset = (uint32_t)offsetof(Location__storage_, latitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "longitude",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Longitude,
        .hasIndex = 6,
        .offset = (uint32_t)offsetof(Location__storage_, longitude),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeDouble,
      },
      {
        .name = "orderId",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_OrderId,
        .hasIndex = 7,
        .offset = (uint32_t)offsetof(Location__storage_, orderId),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeString,
      },
      {
        .name = "speed",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Speed,
        .hasIndex = 8,
        .offset = (uint32_t)offsetof(Location__storage_, speed),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "timestamp",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Timestamp,
        .hasIndex = 9,
        .offset = (uint32_t)offsetof(Location__storage_, timestamp),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeInt64,
      },
      {
        .name = "travelMile",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_TravelMile,
        .hasIndex = 10,
        .offset = (uint32_t)offsetof(Location__storage_, travelMile),
        .flags = (GPBFieldFlags)(GPBFieldOptional | GPBFieldTextFormatNameCustom),
        .dataType = GPBDataTypeFloat,
      },
      {
        .name = "type",
        .dataTypeSpecific.className = NULL,
        .number = Location_FieldNumber_Type,
        .hasIndex = 11,
        .offset = (uint32_t)offsetof(Location__storage_, type),
        .flags = GPBFieldOptional,
        .dataType = GPBDataTypeString,
      },
    };
    GPBDescriptor *localDescriptor =
        [GPBDescriptor allocDescriptorForClass:[Location class]
                                     rootClass:[LocationRoot class]
                                          file:LocationRoot_FileDescriptor()
                                        fields:fields
                                    fieldCount:(uint32_t)(sizeof(fields) / sizeof(GPBMessageFieldDescription))
                                   storageSize:sizeof(Location__storage_)
                                         flags:GPBDescriptorInitializationFlag_None];
#if !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    static const char *extraTextFormatInfo =
        "\006\001\013\000\002\006\000\003\010\000\004\013\000\010\007\000\013\n\000";
    [localDescriptor setupExtraTextInfo:extraTextFormatInfo];
#endif  // !GPBOBJC_SKIP_MESSAGE_TEXTFORMAT_EXTRAS
    #if defined(DEBUG) && DEBUG
      NSAssert(descriptor == nil, @"Startup recursed!");
    #endif  // DEBUG
    descriptor = localDescriptor;
  }
  return descriptor;
}

@end


#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)
