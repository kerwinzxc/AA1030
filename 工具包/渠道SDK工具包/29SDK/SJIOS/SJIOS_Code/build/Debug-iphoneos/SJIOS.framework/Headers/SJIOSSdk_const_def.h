
//正式服务器

#define SJIOS_AD_API_SECRET @"42l$lo4f%24#ldfHjR"



#define SJIOS_SDK_VERSION @"V3.0.2"




#define SJIOS_APPID @"SJIOS_APPID"
#define SJIOS_APPKEY @"SJIOS_APPKEY"
#define SJIOS_APPPRIVATEKEY @"SJIOS_APPPRIVATEKEY"
#define SJIOS_APPSECRET @"SJIOS_APPSECRET"
#define SJIOS_AD_GID @"SJIOS_AD_GID"
#define SJIOS_AD_ADID @"SJIOS_AD_ADID"
#define SJIOS_CHANNEL @"SJIOS_CHANNEL"
#define SJIOS_IMEI @"SJIOS_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define SJIOS_PROTOCOL_CODE @"type"
#define SJIOS_PROTOCOL_BINDPHONE @"phone"
#define SJIOS_PROTOCOL_IDENTITY @"identity"
#define SJIOS_PROTOCOL_ACCESSTOKEN @"access_token"
#define SJIOS_PROTOCOL_PRODUCT_NAME @"product_name"
#define SJIOS_PROTOCOL_PRODUCT_ID @"product_id"
#define SJIOS_PROTOCOL_ACCOUNT @"account"
#define SJIOS_PROTOCOL_APP_NAME @"app_name"
#define SJIOS_PROTOCOL_USER_ID @"user_id"
#define SJIOS_PROTOCOL_ROLE_ID @"role_id"
#define SJIOS_PROTOCOL_ROLE_LEVEL @"role_level"
#define SJIOS_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define SJIOS_PROTOCOL_GATEWAY @"gateway"
#define SJIOS_PROTOCOL_EXTEND_INFO @"extend_info"
#define SJIOS_PROTOCOL_XXX_URL @"XXX_url"


#define SJIOS_NOTIFICATION_PY_FINISH @"py_finish"


typedef void(^SJIOS_SUCCESS_Callback)(NSString *);
typedef void(^SJIOS_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^SJIOS_FAILED_Callback)(int);
typedef void(^SJIOS_VE_BLOCK)(NSError *);
typedef void(^SJIOS_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^SJIOS_ORDER_BLOCK)(NSString *);

typedef void(^SJIOS_COMMON_BLOCK)(NSString *);

