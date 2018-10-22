

#define Usequence_AD_API_SECRET @"42l$lo4f%24#ldfHjR"

#define Usequence_USERCENTER_URL @"https://www.39sdk.com/usercenter/index"

#define Usequence_SDK_VERSION @"V3.4.3"

#define Usequence_TEXTCOLOR_BLACK YES

#define Usequence_APPID @"Usequence_APPID"
#define Usequence_APPKEY @"Usequence_APPKEY"
#define Usequence_APPPRIVATEKEY @"Usequence_APPPRIVATEKEY"
#define Usequence_APPSECRET @"Usequence_APPSECRET"
#define Usequence_AD_GID @"Usequence_AD_GID"
#define Usequence_AD_ADID @"Usequence_AD_ADID"
#define Usequence_CHANNEL @"Usequence_CHANNEL"
#define Usequence_IMEI @"Usequence_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define Usequence_PROTOCOL_CODE @"type"
#define Usequence_PROTOCOL_BINDPHONE @"phone"
#define Usequence_PROTOCOL_IDENTITY @"identity"
#define Usequence_PROTOCOL_ACCESSTOKEN @"access_token"
#define Usequence_PROTOCOL_PRODUCT_NAME @"product_name"
#define Usequence_PROTOCOL_PRODUCT_ID @"product_id"
#define Usequence_PROTOCOL_ACCOUNT @"account"
#define Usequence_PROTOCOL_APP_NAME @"app_name"
#define Usequence_PROTOCOL_USER_ID @"user_id"
#define Usequence_PROTOCOL_ROLE_ID @"role_id"
#define Usequence_PROTOCOL_ROLE_LEVEL @"role_level"
#define Usequence_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define Usequence_PROTOCOL_GATEWAY @"gateway"
#define Usequence_PROTOCOL_EXTEND_INFO @"extend_info"


#define Usequence_NOTIFICATION_PY_FINISH @"py_finish"



typedef void(^Usequence_SUCCESS_Callback)(NSString *);
typedef void(^Usequence_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^Usequence_FAILED_Callback)(int);
typedef void(^Usequence_VE_BLOCK)(NSError *);
typedef void(^Usequence_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^Usequence_ODER_BLOCK)(NSString *);

typedef void(^Usequence_COMMON_BLOCK)(NSString *);

