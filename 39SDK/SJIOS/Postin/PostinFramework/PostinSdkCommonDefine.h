

#define Postin_AD_API_SECRET @"42l$lo4f%24#ldfHjR"

#define Postin_USERCENTER_URL @"https://www.39sdk.com/usercenter/index"

#define Postin_SDK_VERSION @"V3.4.3"

#define Postin_TEXTCOLOR_BLACK YES

#define Postin_APPID @"Postin_APPID"
#define Postin_APPKEY @"Postin_APPKEY"
#define Postin_APPPRIVATEKEY @"Postin_APPPRIVATEKEY"
#define Postin_APPSECRET @"Postin_APPSECRET"
#define Postin_AD_GID @"Postin_AD_GID"
#define Postin_AD_ADID @"Postin_AD_ADID"
#define Postin_CHANNEL @"Postin_CHANNEL"
#define Postin_IMEI @"Postin_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define Postin_PROTOCOL_CODE @"type"
#define Postin_PROTOCOL_BINDPHONE @"phone"
#define Postin_PROTOCOL_IDENTITY @"identity"
#define Postin_PROTOCOL_ACCESSTOKEN @"access_token"
#define Postin_PROTOCOL_PRODUCT_NAME @"product_name"
#define Postin_PROTOCOL_PRODUCT_ID @"product_id"
#define Postin_PROTOCOL_ACCOUNT @"account"
#define Postin_PROTOCOL_APP_NAME @"app_name"
#define Postin_PROTOCOL_USER_ID @"user_id"
#define Postin_PROTOCOL_ROLE_ID @"role_id"
#define Postin_PROTOCOL_ROLE_LEVEL @"role_level"
#define Postin_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define Postin_PROTOCOL_GATEWAY @"gateway"
#define Postin_PROTOCOL_EXTEND_INFO @"extend_info"


#define Postin_NOTIFICATION_PY_FINISH @"py_finish"



typedef void(^Postin_SUCCESS_Callback)(NSString *);
typedef void(^Postin_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^Postin_FAILED_Callback)(int);
typedef void(^Postin_VE_BLOCK)(NSError *);
typedef void(^Postin_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^Postin_ODER_BLOCK)(NSString *);

typedef void(^Postin_COMMON_BLOCK)(NSString *);

