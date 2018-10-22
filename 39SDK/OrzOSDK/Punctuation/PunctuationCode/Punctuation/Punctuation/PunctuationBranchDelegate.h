

@protocol PunctuationBranchDelegate<NSObject>

-(void)channel_initPunctuationSuccess:(NSDictionary *)result;

-(void)channel_initPunctuationFail:(NSDictionary *)result;

-(void)channel_loginPunctuationSuccess:(NSDictionary *)result;

-(void)channel_loginPunctuationFail:(NSDictionary *)result;

-(void)channel_logoutPunctuationSuccess:(NSDictionary *)result;

-(void)channel_logoutPunctuationFail:(NSDictionary *)result;

-(void)channel_RegchargPunctuationSuccess:(NSDictionary *)result;

-(void)channel_RegchargPunctuationFail:(NSDictionary *)result;

-(void)channel_openPunctuationUserCenter;
-(void)channel_closePunctuationUserCenter;

@end
