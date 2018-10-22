

#import "UsequenceUserInfo.h"

@implementation UsequenceUserInfo

-(id) initWithInfo:(NSString *)username password:(NSString *)password bind:(NSString*)bind tourist:(NSString*)tourist loginTime:(NSString*)loginTime phoneNumber:(NSString*) phoneNumber
{
    self=[super init];
    if (self) {
        self.username=username;
        self.password=password;
        self.bind=bind;
        self.tourist=tourist;
        self.loginTime=loginTime;
        self.phoneNumber=phoneNumber;
    }
    return self;
}



@end
