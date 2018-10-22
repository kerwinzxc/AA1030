

#define Qrought_AD_API_SECRET @"42l$lo4f%24#ldfHjR"

#define Qrought_USERCENTER_URL @"https://www.39sdk.com/usercenter/index"

#define Qrought_SDK_VERSION @"V3.4.3"

#define Qrought_TEXTCOLOR_BLACK YES

#define Qrought_APPID @"Qrought_APPID"
#define Qrought_APPKEY @"Qrought_APPKEY"
#define Qrought_APPPRIVATEKEY @"Qrought_APPPRIVATEKEY"
#define Qrought_APPSECRET @"Qrought_APPSECRET"
#define Qrought_AD_GID @"Qrought_AD_GID"
#define Qrought_AD_ADID @"Qrought_AD_ADID"
#define Qrought_CHANNEL @"Qrought_CHANNEL"
#define Qrought_IMEI @"Qrought_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define Qrought_PROTOCOL_CODE @"type"
#define Qrought_PROTOCOL_BINDPHONE @"phone"
#define Qrought_PROTOCOL_IDENTITY @"identity"
#define Qrought_PROTOCOL_ACCESSTOKEN @"access_token"
#define Qrought_PROTOCOL_PRODUCT_NAME @"product_name"
#define Qrought_PROTOCOL_PRODUCT_ID @"product_id"
#define Qrought_PROTOCOL_ACCOUNT @"account"
#define Qrought_PROTOCOL_APP_NAME @"app_name"
#define Qrought_PROTOCOL_USER_ID @"user_id"
#define Qrought_PROTOCOL_ROLE_ID @"role_id"
#define Qrought_PROTOCOL_ROLE_LEVEL @"role_level"
#define Qrought_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define Qrought_PROTOCOL_GATEWAY @"gateway"
#define Qrought_PROTOCOL_EXTEND_INFO @"extend_info"


#define Qrought_NOTIFICATION_PY_FINISH @"py_finish"



typedef void(^Qrought_SUCCESS_Callback)(NSString *);
typedef void(^Qrought_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^Qrought_FAILED_Callback)(int);
typedef void(^Qrought_VE_BLOCK)(NSError *);
typedef void(^Qrought_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^Qrought_ODER_BLOCK)(NSString *);

typedef void(^Qrought_COMMON_BLOCK)(NSString *);

