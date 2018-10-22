

@protocol EasterBranchDelegate<NSObject>

-(void)channel_initEasterSuccess:(NSDictionary *)result;

-(void)channel_initEasterFail:(NSDictionary *)result;

-(void)channel_loginEasterSuccess:(NSDictionary *)result;

-(void)channel_loginEasterFail:(NSDictionary *)result;

-(void)channel_logoutEasterSuccess:(NSDictionary *)result;

-(void)channel_logoutEasterFail:(NSDictionary *)result;

-(void)channel_RegchargEasterSuccess:(NSDictionary *)result;

-(void)channel_RegchargEasterFail:(NSDictionary *)result;

-(void)channel_openEasterUserCenter;
-(void)channel_closeEasterUserCenter;

@end
