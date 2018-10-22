

@protocol GhargeBranchDelegate<NSObject>

-(void)channel_initGhargeSuccess:(NSDictionary *)result;

-(void)channel_initGhargeFail:(NSDictionary *)result;

-(void)channel_loginGhargeSuccess:(NSDictionary *)result;

-(void)channel_loginGhargeFail:(NSDictionary *)result;

-(void)channel_logoutGhargeSuccess:(NSDictionary *)result;

-(void)channel_logoutGhargeFail:(NSDictionary *)result;

-(void)channel_RegchargGhargeSuccess:(NSDictionary *)result;

-(void)channel_RegchargGhargeFail:(NSDictionary *)result;

-(void)channel_openGhargeUserCenter;
-(void)channel_closeGhargeUserCenter;

@end
