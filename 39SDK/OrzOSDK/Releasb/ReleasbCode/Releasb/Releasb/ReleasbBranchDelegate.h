

@protocol ReleasbBranchDelegate<NSObject>

-(void)channel_initReleasbSuccess:(NSDictionary *)result;

-(void)channel_initReleasbFail:(NSDictionary *)result;

-(void)channel_loginReleasbSuccess:(NSDictionary *)result;

-(void)channel_loginReleasbFail:(NSDictionary *)result;

-(void)channel_logoutReleasbSuccess:(NSDictionary *)result;

-(void)channel_logoutReleasbFail:(NSDictionary *)result;

-(void)channel_RegchargReleasbSuccess:(NSDictionary *)result;

-(void)channel_RegchargReleasbFail:(NSDictionary *)result;

-(void)channel_openReleasbUserCenter;
-(void)channel_closeReleasbUserCenter;

@end
