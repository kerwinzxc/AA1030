

#define Rersistence_AD_API_SECRET @"42l$lo4f%24#ldfHjR"

#define Rersistence_USERCENTER_URL @"https://www.39sdk.com/usercenter/index"

#define Rersistence_SDK_VERSION @"V3.4.3"

#define Rersistence_TEXTCOLOR_BLACK YES

#define Rersistence_APPID @"Rersistence_APPID"
#define Rersistence_APPKEY @"Rersistence_APPKEY"
#define Rersistence_APPPRIVATEKEY @"Rersistence_APPPRIVATEKEY"
#define Rersistence_APPSECRET @"Rersistence_APPSECRET"
#define Rersistence_AD_GID @"Rersistence_AD_GID"
#define Rersistence_AD_ADID @"Rersistence_AD_ADID"
#define Rersistence_CHANNEL @"Rersistence_CHANNEL"
#define Rersistence_IMEI @"Rersistence_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define Rersistence_PROTOCOL_CODE @"type"
#define Rersistence_PROTOCOL_BINDPHONE @"phone"
#define Rersistence_PROTOCOL_IDENTITY @"identity"
#define Rersistence_PROTOCOL_ACCESSTOKEN @"access_token"
#define Rersistence_PROTOCOL_PRODUCT_NAME @"product_name"
#define Rersistence_PROTOCOL_PRODUCT_ID @"product_id"
#define Rersistence_PROTOCOL_ACCOUNT @"account"
#define Rersistence_PROTOCOL_APP_NAME @"app_name"
#define Rersistence_PROTOCOL_USER_ID @"user_id"
#define Rersistence_PROTOCOL_ROLE_ID @"role_id"
#define Rersistence_PROTOCOL_ROLE_LEVEL @"role_level"
#define Rersistence_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define Rersistence_PROTOCOL_GATEWAY @"gateway"
#define Rersistence_PROTOCOL_EXTEND_INFO @"extend_info"


#define Rersistence_NOTIFICATION_PY_FINISH @"py_finish"



typedef void(^Rersistence_SUCCESS_Callback)(NSString *);
typedef void(^Rersistence_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^Rersistence_FAILED_Callback)(int);
typedef void(^Rersistence_VE_BLOCK)(NSError *);
typedef void(^Rersistence_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^Rersistence_ODER_BLOCK)(NSString *);

typedef void(^Rersistence_COMMON_BLOCK)(NSString *);

