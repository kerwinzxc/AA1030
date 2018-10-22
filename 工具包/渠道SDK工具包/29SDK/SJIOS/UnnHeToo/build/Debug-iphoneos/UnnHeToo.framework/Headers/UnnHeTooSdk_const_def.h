
//正式服务器

#define UnnHeToo_AD_API_SECRET @"42l$lo4f%24#ldfHjR"



#define UnnHeToo_SDK_VERSION @"V3.0.2"




#define UnnHeToo_APPID @"UnnHeToo_APPID"
#define UnnHeToo_APPKEY @"UnnHeToo_APPKEY"
#define UnnHeToo_APPPRIVATEKEY @"UnnHeToo_APPPRIVATEKEY"
#define UnnHeToo_APPSECRET @"UnnHeToo_APPSECRET"
#define UnnHeToo_AD_GID @"UnnHeToo_AD_GID"
#define UnnHeToo_AD_ADID @"UnnHeToo_AD_ADID"
#define UnnHeToo_CHANNEL @"UnnHeToo_CHANNEL"
#define UnnHeToo_IMEI @"UnnHeToo_IMEI"

#define SJYX_IDFV @"SJYX_IDFV"

#define UnnHeToo_PROTOCOL_CODE @"type"
#define UnnHeToo_PROTOCOL_BINDPHONE @"phone"
#define UnnHeToo_PROTOCOL_IDENTITY @"identity"
#define UnnHeToo_PROTOCOL_ACCESSTOKEN @"access_token"
#define UnnHeToo_PROTOCOL_PRODUCT_NAME @"product_name"
#define UnnHeToo_PROTOCOL_PRODUCT_ID @"product_id"
#define UnnHeToo_PROTOCOL_ACCOUNT @"account"
#define UnnHeToo_PROTOCOL_APP_NAME @"app_name"
#define UnnHeToo_PROTOCOL_USER_ID @"user_id"
#define UnnHeToo_PROTOCOL_ROLE_ID @"role_id"
#define UnnHeToo_PROTOCOL_ROLE_LEVEL @"role_level"
#define UnnHeToo_PROTOCOL_APP_ORDER_ID @"app_order_id"
#define UnnHeToo_PROTOCOL_GATEWAY @"gateway"
#define UnnHeToo_PROTOCOL_EXTEND_INFO @"extend_info"
#define UnnHeToo_PROTOCOL_XXX_URL @"XXX_url"


#define UnnHeToo_NOTIFICATION_PY_FINISH @"py_finish"


typedef void(^UnnHeToo_SUCCESS_Callback)(NSString *);
typedef void(^UnnHeToo_RV_Complete_Callback)(NSString *, NSString*);
typedef void(^UnnHeToo_FAILED_Callback)(int);
typedef void(^UnnHeToo_VE_BLOCK)(NSError *);
typedef void(^UnnHeToo_VSD_BLOCK)(NSDictionary *, NSDictionary *);

typedef void(^UnnHeToo_ORDER_BLOCK)(NSString *);

typedef void(^UnnHeToo_COMMON_BLOCK)(NSString *);

