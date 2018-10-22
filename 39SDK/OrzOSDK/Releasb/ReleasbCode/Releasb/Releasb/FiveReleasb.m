#import "FiveReleasb.h"
#import <Foundation/Foundation.h>

@implementation FiveReleasb


-(void)jia{
    int sum = 0;
    for(int a = 0; a < 100; a++){
        sum = sum + a;
    }
    
    NSLog(@"sum = %d", sum);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, 80, 25)];
    [label setText:@"用户注册"];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont systemFontOfSize:20];
    [label sizeToFit];
    [self.alertContainer addSubview:label];
    
    
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
}

-(void)jian{
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    int sum = 0;
    for(int a = 0; a < 100; a++){
        sum = sum - a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chengReleasb{
    int sum = 0;
    for(int a = 0; a < 20; a++){
        sum = sum * a;
    }
    
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    
    NSLog(@"sum = %d", sum);
}

-(void)chu{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}


-(void)jiasdaReleasb{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)jiaasdfnReleasb{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)cheqefng{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)cdvhu{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}


-(void)jiasdfa{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)jiawthn{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chjkeng{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chtynu{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}


-(void)jiwrtwera{
    
}

-(void)jiqwegan{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chebnng{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chjjiu{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}


-(void)rrjia{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)jiattn{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chyyeng{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}

-(void)chuuu{
    int sum = 0;
    //关闭按钮
    UIButton *closeButton=[[UIButton alloc]initWithFrame:CGRectMake(255, 10, 15, 15)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"gamegodsdkresources.bundle/2155_close.png"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(ym_registerClose) forControlEvents:UIControlEventTouchUpInside];
    [self.alertContainer addSubview:closeButton];
    
    
    //2155登录名
    UITextField * username = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 240, 40)];
    username.borderStyle = UITextBorderStyleNone;
    username.layer.borderColor = [UIColor grayColor].CGColor;//边框色
    username.layer.borderWidth = 1.0f;//边框宽度
    UIImage *username_edit_image = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_edit_background.png"]];
    
    username.background = username_edit_image;
    username.placeholder = @"请输入2155账号";
    [username setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    username.font = [UIFont systemFontOfSize:15];
    username.clearButtonMode = UITextFieldViewModeWhileEditing;
    username.autocorrectionType = UITextAutocorrectionTypeNo;
    
    username.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    username.autocapitalizationType = UITextAutocapitalizationTypeNone;
    username.returnKeyType = UIReturnKeyNext;
    
    UIImage * logo_username = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"gamegodsdkresources.bundle/2155_username_logo.png"]];
    UIImageView * logoUsername = [[UIImageView alloc] initWithImage:logo_username];
    logoUsername.frame = CGRectMake(5, 0, 20, 20);
    
    UIView * usernameLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [usernameLeftView addSubview:logoUsername];
    username.leftView = usernameLeftView;
    username.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];[data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    [data setValue:@"ytj" forKey:@"idfa"];
    [data setValue:@"fhjk" forKey:@"idfv"];
    [data setValue:@"asdf" forKey:@"uuid"];
    [data setValue:@"wefu" forKey:@"imei"];
    [data setValue:@"umyt" forKey:@"mac"];
    [data setValue:@"1" forKey:@"platform"];
    [data setValue:@"qwdgh" forKey:@"version"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"device_user_name"];
    [data setValue:[[[ASIdentifierManager sharedManager]advertisingIdentifier] UUIDString] forKey:@"app_name"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"app_build_version"];
    [data setValue:[[UIDevice currentDevice] systemVersion] forKey:@"juhesdk_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"channel_version"];
    [data setValue:[[UIDevice currentDevice] name] forKey:@"net_isp"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"net_status"];
    [data setValue:[[UIDevice currentDevice] systemName] forKey:@"sign"];[data setValue:@"12d" forKey:@"package_id"];
    [data setValue:@"qwrg" forKey:@"bundleid"];
    
    NSLog(@"dic = %@", data);
    for(int a = 0; a < 20; a++){
        sum = sum / a;
    }
    
    NSLog(@"sum = %d", sum);
}


@end

