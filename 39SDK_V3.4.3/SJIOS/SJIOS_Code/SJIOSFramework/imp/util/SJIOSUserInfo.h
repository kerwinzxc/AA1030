

#import <Foundation/Foundation.h>

@interface SJIOSUserInfo : NSObject
@property (nonatomic ,strong) NSString *username;
@property (nonatomic,strong) NSString *password;

//0 no 1 yes
@property (nonatomic,strong) NSString *bind;
@property (nonatomic,strong) NSString  *tourist;
@property (nonatomic,strong) NSString  *loginTime;

//0不是手机帐号 1 是手机帐号
@property (nonatomic,strong) NSString *phoneNumber;



-(id)initWithInfo:(NSString*) username
         password:(NSString*) password
             bind:(NSString*) bind
          tourist:(NSString*) tourist
        loginTime:(NSString*) loginTime
      phoneNumber:(NSString*) phoneNumber;


@end
