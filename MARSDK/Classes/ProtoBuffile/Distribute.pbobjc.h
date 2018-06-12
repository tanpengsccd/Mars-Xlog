// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: distribute.proto

// This CPP symbol can be defined to use imports that match up to the framework
// imports needed when using CocoaPods.
#if !defined(GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS)
 #define GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS 0
#endif

#if GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS
 #import <Protobuf/GPBProtocolBuffers.h>
#else
 #import "GPBProtocolBuffers.h"
#endif

#if GOOGLE_PROTOBUF_OBJC_VERSION < 30002
#error This file was generated by a newer version of protoc which is incompatible with your Protocol Buffer library sources.
#endif
#if 30002 < GOOGLE_PROTOBUF_OBJC_MIN_SUPPORTED_VERSION
#error This file was generated by an older version of protoc which is incompatible with your Protocol Buffer library sources.
#endif

// @@protoc_insertion_point(imports)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

CF_EXTERN_C_BEGIN

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Enum DistributeType

typedef GPB_ENUM(DistributeType) {
  /**
   * Value used if any message's field encounters a value that is not defined
   * by this enum. The message will also have C functions to get/set the rawValue
   * of the field.
   **/
  DistributeType_GPBUnrecognizedEnumeratorValue = kGPBUnrecognizedEnumeratorValue,
  /** 转人工 */
  DistributeType_DistributeTypeTrunManual = 0,

  /** 刚进入客服页面,决定是否发欢迎语 */
  DistributeType_DistributeTypeJustEnterKfPage = 1,

  /** 客服转客服 */
  DistributeType_DistributeTypeManualTrunManual = 2,
};

GPBEnumDescriptor *DistributeType_EnumDescriptor(void);

/**
 * Checks to see if the given value is defined by the enum or was not known at
 * the time this source was generated.
 **/
BOOL DistributeType_IsValidValue(int32_t value);

#pragma mark - DistributeRoot

/**
 * Exposes the extension registry for this file.
 *
 * The base class provides:
 * @code
 *   + (GPBExtensionRegistry *)extensionRegistry;
 * @endcode
 * which is a @c GPBExtensionRegistry that includes all the extensions defined by
 * this file and all files that it depends on.
 **/
@interface DistributeRoot : GPBRootObject
@end

#pragma mark - DistributeRequest

typedef GPB_ENUM(DistributeRequest_FieldNumber) {
  DistributeRequest_FieldNumber_From = 1,
  DistributeRequest_FieldNumber_FromDomain = 2,
  DistributeRequest_FieldNumber_Guid = 3,
  DistributeRequest_FieldNumber_SceneId = 4,
  DistributeRequest_FieldNumber_Content = 5,
  DistributeRequest_FieldNumber_Type = 6,
  DistributeRequest_FieldNumber_AppId = 7,
  DistributeRequest_FieldNumber_ClientType = 8,
  DistributeRequest_FieldNumber_ChatId = 9,
  DistributeRequest_FieldNumber_Ext = 10,
};

/**
 * 分配客服
 **/
@interface DistributeRequest : GPBMessage

/** 发送者ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *from;

/** 发送者所属用户类型,具体见DomainType */
@property(nonatomic, readwrite) int32_t fromDomain;

/** 发送者guid */
@property(nonatomic, readwrite, copy, null_resettable) NSString *guid;

/** 场景ID */
@property(nonatomic, readwrite, copy, null_resettable) NSString *sceneId;

/** 富文本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *content;

/** 类型，如用户刚打开聊天界面，转人工。详见DistributeType */
@property(nonatomic, readwrite) int32_t type;

/** app标识，如瓜子、毛豆app */
@property(nonatomic, readwrite, copy, null_resettable) NSString *appId;

/** 端类型 */
@property(nonatomic, readwrite) int32_t clientType;

/** 会话ID */
@property(nonatomic, readwrite) int64_t chatId;

/** 扩展内容，建议采用富文本 */
@property(nonatomic, readwrite, copy, null_resettable) NSString *ext;

@end

#pragma mark - DistributeResponse

typedef GPB_ENUM(DistributeResponse_FieldNumber) {
  DistributeResponse_FieldNumber_Msgid = 1,
  DistributeResponse_FieldNumber_Timestamp = 2,
};

@interface DistributeResponse : GPBMessage

/** 落地存储的消息id（针对此条消息） */
@property(nonatomic, readwrite) int64_t msgid;

/** 收到群聊消息的时间戳 */
@property(nonatomic, readwrite) int64_t timestamp;

@end

NS_ASSUME_NONNULL_END

CF_EXTERN_C_END

#pragma clang diagnostic pop

// @@protoc_insertion_point(global_scope)