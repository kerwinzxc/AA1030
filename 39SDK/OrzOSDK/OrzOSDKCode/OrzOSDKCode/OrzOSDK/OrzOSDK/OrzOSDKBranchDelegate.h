

@protocol OrzOSDKBranchDelegate<NSObject>

-(void)channel_initOrzOSDKSuccess:(NSDictionary *)result;

-(void)channel_initOrzOSDKFail:(NSDictionary *)result;

-(void)channel_loginOrzOSDKSuccess:(NSDictionary *)result;

-(void)channel_loginOrzOSDKFail:(NSDictionary *)result;

-(void)channel_logoutOrzOSDKSuccess:(NSDictionary *)result;

-(void)channel_logoutOrzOSDKFail:(NSDictionary *)result;

-(void)channel_RegchargOrzOSDKSuccess:(NSDictionary *)result;

-(void)channel_RegchargOrzOSDKFail:(NSDictionary *)result;

-(void)channel_openOrzOSDKUserCenter;
-(void)channel_closeOrzOSDKUserCenter;

@end
