

#import "GhargeBranch_39.h"
#import <Qrought/QroughtSdk.h>

#import <Qrought/AQrought.h>
#import <Qrought/BQrought.h>
#import <Qrought/CQrought.h>


@implementation GhargeBranch_39

-(NSString *)getGhargeChannelSdkVersion{
    return @"3.4.3";
    
}


-(void)doGhargeChannelInit{
    NSLog(@"GhargeBranch_SanJHY doChannelInit !");
    
    self.isLogined = NO;
    self.loginViewIsShowing = NO;
    
    NSDictionary *NsDictionary = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"GhargeParams"];
    
    [QroughtSdk initQrought:[[GhargeUtils getSharedInstance] getGhargeInfoPlist_Landscape]
            Qrought_Appid:[NsDictionary objectForKey:@"Gharge_APPID"]
           Qrought_Appkey:[NsDictionary objectForKey:@"Gharge_APPKEY"]
          Qrought_Channel:[NsDictionary objectForKey:@"Gharge_Channel"]
        Qrought_Appsecret:[NsDictionary objectForKey:@"Gharge_SecretKey"]
              Qrought_Gid:[NsDictionary objectForKey:@"Gharge_GID"]
         Qrought_RYAppkey:[NsDictionary objectForKey:@"Gharge_ReYun"]
        Qrought_PackageId:[[GhargeUtils getSharedInstance] getGhargeInfoPlist_PackageId]
                success:^(NSString* info){
                    NSLog(@"init success %@", info);
                    [self.delegate channel_initGhargeSuccess:@{@"code":@"1",@"msg":@"success"}];
                    
                    [QroughtSdk checkQroughtUpdate:[self getGhargeCurrentView] successQrought:^(NSString * result) {
                        NSLog(@"checkUpdate success %@", result);
                    } failedQrought:^(int code){
                        NSLog(@"checkUpdate failed %d", code);
                    } landscapeQrought:YES];
                    
                } failed:^(int error){
                    NSLog(@"init failed %d", error);
                    [self.delegate channel_initGhargeFail:@{@"code":@"-2",@"msg":@"failed"}];
                }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerOK:) name:@"registerOK" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSJUserCenter:) name:@"openSJUserCenter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeSJUserCenter:) name:@"closeSJUserCenter" object:nil];
    
}

//账号注册成功通知,notification.userInfo为账号id----
-(void)registerOK:(NSNotification *)notification{
    NSLog(@"-------");
    NSLog(@"-----------%@", notification.userInfo);
    
}

-(void)openSJUserCenter:(NSNotification *)notification{
    NSLog(@"---openSJUserCenter----");
    [self.delegate channel_openGhargeUserCenter];
    
}


-(void)closeSJUserCenter:(NSNotification *)notification{
    NSLog(@"---closeSJUserCenter----");
    [self.delegate channel_closeGhargeUserCenter];
    
}

-(void)doGhargeChannelLogin{
    
    NSLog(@"GhargeBranch doChannelLogin");
    if(self.loginViewIsShowing == NO){
        self.loginViewIsShowing = YES;
        [QroughtSdk loginQrought:[self getGhargeCurrentView] landscapeQrought:[[GhargeUtils getSharedInstance] getGhargeInfoPlist_Landscape] successQrought:^(NSString* userInfo){
            
            
            NSError *error = nil;
            NSDictionary *dictionary = (NSDictionary *)userInfo;
            if (dictionary == nil)
            {
                NSLog(@"333");
                [self.delegate channel_loginGhargeFail:@{@"code":@"-1",@"msg":@"loginfailed"}];
                return;
            }
            self.loginViewIsShowing = NO;
            self.isLogined = YES;
            
            
            self.userId = [dictionary objectForKey:@"userid"];
            self.accesstoken = [dictionary objectForKey:@"accesstoken"];
            NSString *username = [dictionary objectForKey:@"username"];
            
            NSLog(@"111  userid = %@", self.userId);
            NSLog(@"111  accesstoken = %@", self.accesstoken);
            NSLog(@"111  username = %@", username);
            
            [self.delegate channel_loginGhargeSuccess:@{@"channel_uid":[dictionary objectForKey:@"userid"],
                                                         @"channel_username":@"",
                                                         @"channel_token":[dictionary objectForKey:@"accesstoken"],
                                                         @"channel_deviceid":@""}];
            [self doChannelhideGhargeFloatView];
            [self doChannelshowGhargeFloatView];
            
        } failedQrought:^(int error){
            NSLog(@"222");
            [self.delegate channel_loginGhargeFail:@{@"code":@"-2",@"msg":@"loginfailed"}];
        }];
        
    }
    
    
}

-(void)doGhargeChannelRealNameRegister:(int)flag callback:(GhargeShiMimgRenZhengCallback)callbackxxx{
    [QroughtSdk showQroughtShiMingRenZhengView:self.accesstoken callbackQrought:^(NSString *callback){
        if(flag == 1){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_loginGhargeSuccess:@{@"channel_uid":self.userId,
                                                             @"channel_username":@"",
                                                             @"channel_token":self.accesstoken,
                                                             @"channel_deviceid":@""}];
            }else{
                [self.delegate channel_loginGhargeFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"1");
        }else if(flag == 2){
            if([callback isEqualToString:@"success"]){
                [self.delegate channel_RegchargGhargeFail:@{@"code":@"-2",@"msg":@"请重新下单"}];
            }else{
                [self.delegate channel_RegchargGhargeFail:@{@"code":@"-2",@"msg":callback}];
            }
            callbackxxx(@"2");
        }
    }];
}

-(void)doGhargeChannelSwitchAccount{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [QroughtSdk logoutQrought:[self getGhargeCurrentView] successQrought:^(NSString *info){
            NSLog(@"logout success");
            
            [self.delegate channel_logoutGhargeSuccess:@{@"code":@"1",@"msg":@"switch account success"}];
        }failedQrought:^(int error){
            NSLog(@"logout failed");
            
            [self.delegate channel_logoutGhargeSuccess:@{@"code":@"-1",@"msg":@"switch account failed"}];
        }];
    }
}


-(void)doGhargeChannelLogout{
    if(self.isLogined == YES){
        self.isLogined = NO;
        self.loginViewIsShowing = NO;
        [self.delegate channel_logoutGhargeSuccess:@{@"code":@"1",@"msg":@"logout success"}];
        [self doChannelhideGhargeFloatView];
    }
    
}

-(void)doChannelshowGhargeGameCenter{
    
}

-(void)doChannelshowGhargeFloatView{
    [QroughtSdk executeQrought:[self getGhargeCurrentViewController] landscapeQrought:[[GhargeUtils getSharedInstance] getGhargeInfoPlist_Landscape]];
}

-(void)doChannelhideGhargeFloatView{
    [QroughtSdk hideFloatQrought];
}

-(void)doGhargeChannelRegcharg:(NSDictionary *)params{
    
    NSLog(@"start py");
    
    NSMutableDictionary * sj_params = [NSMutableDictionary dictionary];
    [sj_params setValue:[params objectForKey:Gharge_IOS_PRODUCT_NAME] forKey:Qrought_PROTOCOL_PRODUCT_NAME];//商品名称，若无，则传商品价格
    [sj_params setValue:[params objectForKey:Gharge_IOS_PRODUCT_ID] forKey:Qrought_PROTOCOL_PRODUCT_ID];//苹果内购id
    [sj_params setValue:[params objectForKey:Gharge_IOS_PRODUCT_PRICE] forKey:Qrought_PROTOCOL_ACCOUNT];//商品价格
    [sj_params setValue:[[GhargeUtils getSharedInstance] getGhargeBundleId] forKey:Qrought_PROTOCOL_APP_NAME];//应用名称，由提供
    [sj_params setValue:self.userId forKey:Qrought_PROTOCOL_USER_ID];//用户id
    [sj_params setValue:[params objectForKey:Gharge_IOS_ORDERID] forKey:Qrought_PROTOCOL_APP_ORDER_ID];//游戏内订单号
    [sj_params setValue:self.serverId forKey:Qrought_PROTOCOL_GATEWAY];//区服id
    [sj_params setValue:[params objectForKey:Gharge_IOS_ORDERID] forKey:Qrought_PROTOCOL_EXTEND_INFO];//透传信息，若无，则传1
    [sj_params setValue:self.roleId forKey:Qrought_PROTOCOL_ROLE_ID];//角色id
    [sj_params setValue:self.roleLevel forKey:Qrought_PROTOCOL_ROLE_LEVEL];//角色level
    [QroughtSdk startPQroughty:[self getGhargeCurrentViewController] landscapeQrought:[[GhargeUtils getSharedInstance] getGhargeInfoPlist_Landscape] paramsQrought:sj_params successQrought:^(NSString * info) {
        NSLog(@"py:%@",info);
        [self.delegate channel_RegchargGhargeSuccess:@{@"code":@"0",@"msg":info}];
        
    } failedQrought:^(int error) {
        NSLog(@"error:%d",error);
        NSString *err = [[NSString alloc] initWithFormat:@"%d", error];
        [self.delegate channel_RegchargGhargeFail:@{@"code":@"-2",@"msg":err}];
    }];
    
    
}

-(void)doGhargeChannelSendGameData:(NSString *)dataPoint data:(NSDictionary *)data{
    self.serverId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Gharge_SERVER_ID]];
    self.roleId = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Gharge_ROLE_ID]];
    self.roleLevel = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:Gharge_ROLE_LEVEL]];
    if([dataPoint isEqualToString:Gharge_SUBMIT_ROLE_CREATE]){
        [QroughtSdk createRoleQrought:[data objectForKey:Gharge_SERVER_ID] userIdQrought:self.userId roleIdQrought:[data objectForKey:Gharge_ROLE_ID] roleLevelQrought:[data objectForKey:Gharge_ROLE_LEVEL] successQrought:^(NSString *success) {
            NSLog(@"createRole:%@",success);
        } failedQrought:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Gharge_SUBMIT_ROLE_LEVELUP]){
        
        [QroughtSdk levelupQrought:[data objectForKey:Gharge_ROLE_LEVEL] serverNameQrought:[data objectForKey:Gharge_SERVER_NAME] serveridQrought:[data objectForKey:Gharge_SERVER_ID] userIdQrought:self.userId role_idQrought:[data objectForKey:Gharge_ROLE_ID] roleNameQrought:[data objectForKey:Gharge_ROLE_NAME] successQrought:^(NSString *success) {
            NSLog(@"roleLevelUp:%@",success);
        } failedQrought:^(int code) {
            
        }];
    }else if([dataPoint isEqualToString:Gharge_SUBMIT_ROLE_ENTERSERVER]){
        [QroughtSdk loginRoleQrought:[data objectForKey:Gharge_SERVER_ID] userIdQrought:self.userId roleIdQrought:[data objectForKey:Gharge_ROLE_ID]  roleLevelQrought:[data objectForKey:Gharge_ROLE_LEVEL] successQrought:^(NSString *success) {
            NSLog(@"loginRole:%@",success);
            
        } failedQrought:^(int code) {
            
        }];
    }
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    return TRUE;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application{
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application{
    
}
- (void)applicationWillTerminate:(UIApplication *)application{
    
}

- (UIColor *)_colorValueFromArray:(NSArray<NSNumber *>  *)colorArray {
    if (colorArray.count == 4) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in colorArray) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }
        }
        return [UIColor colorWithRed:colorArray[0].floatValue / (shouldUse255 ? 255.f : 1.f)
                               green:colorArray[1].floatValue / (shouldUse255 ? 255.f : 1.f)
                                blue:colorArray[2].floatValue / (shouldUse255 ? 255.f : 1.f)
                               alpha:colorArray[3].floatValue / (shouldUse255 ? 255.f : 1.f)];
    }
    return nil;
}
- (instancetype)initWithData:(NSDictionary *)bezierData
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:
            @"nationalNumberPattern[%@] possibleNumberPattern[%@] possibleLength[%@] "
            @"possibleLengthLocalOnly[%@] exampleNumber[%@]",
            self.nationalNumberPattern, self.possibleNumberPattern, self.possibleLength,
            self.possibleLengthLocalOnly, self.exampleNumber];
}

- (void)setupOutpithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)deff:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)setupOuttyhtyhhpithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}- (void)setupOuithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}- (void)setupithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)setithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

- (void)sithData:(id)data {
    if ([data isKindOfClass:[NSNumber class]]) {
        _floatValue = [(NSNumber *)data floatValue];
    }
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSNumber class]]) {
        NSArray *numberArray = (NSArray *)data;
        if (numberArray.count > 0) {
            _floatValue = [(NSNumber *)numberArray[0] floatValue];
        }
        if (numberArray.count > 1) {
            _pointValue = CGPointMake(_floatValue = [(NSNumber *)numberArray[0] floatValue],
                                      _floatValue = [(NSNumber *)numberArray[1] floatValue]);
            _sizeValue = CGSizeMake(_pointValue.x, _pointValue.y);
        }
        if (numberArray.count > 3) {
            _colorValue = [self _colorValueFromArray:numberArray];
        }
        _arrayValue = numberArray;
    } else if ([data isKindOfClass:[NSArray class]] &&
               [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:[(NSArray *)data firstObject]];
    } else if ([data isKindOfClass:[NSDictionary class]]) {
        _pathData = [[GhargeBranch_39 alloc] initWithData:data];
    }
    
    NSNumber *xValue = @0, *yValue = @0;
    if ([data[@"x"] isKindOfClass:[NSNumber class]]) {
        xValue = data[@"x"];
    } else if ([data[@"x"] isKindOfClass:[NSArray class]]) {
        xValue = data[@"x"][0];
    }
    if ([data[@"y"] isKindOfClass:[NSNumber class]]) {
        yValue = data[@"y"];
    } else if ([data[@"y"] isKindOfClass:[NSArray class]]) {
        yValue = data[@"y"][0];
    }
    int abc = 10;
    if (abc == 10) {
        BOOL shouldUse255 = NO;
        for (NSNumber *number in data) {
            if (number.floatValue > 1) {
                shouldUse255 = YES;
            }}}
    if (self) {
        if ([data isKindOfClass:[NSDictionary class]] &&
            [(NSDictionary *)data valueForKey:@"k"]) {
            [self initWithData:[(NSDictionary *)data valueForKey:@"k"]];
        } else {
            [self initWithData:data];
        }}
    if ([data isKindOfClass:[NSArray class]] &&
        [[(NSArray *)data firstObject] isKindOfClass:[NSDictionary class]] &&
        [(NSArray *)data firstObject][@"t"]) {
        // Array of Keyframes
        NSArray *keyframes =  (NSArray *)data;
        NSMutableArray *keys = [NSMutableArray array];
        NSDictionary *previousFrame = nil;
        for (NSDictionary *keyframe in keyframes) {
            NSMutableDictionary *currentFrame = [NSMutableDictionary dictionary];
            if (keyframe[@"t"]) {
                // Set time
                currentFrame[@"t"] = keyframe[@"t"];
            }
            if (keyframe[@"s"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = keyframe[@"s"];
            } else if (previousFrame[@"e"]) {
                // Set Value for Keyframe
                currentFrame[@"s"] = previousFrame[@"e"];
            }
            if (keyframe[@"o"]) {
                // Set out tangent
                currentFrame[@"o"] = keyframe[@"o"];
            }
            if (previousFrame[@"i"]) {
                currentFrame[@"i"] = previousFrame[@"i"];
            }
            if (keyframe[@"to"]) {
                // Set out tangent
                currentFrame[@"to"] = keyframe[@"to"];
            }
            if (previousFrame[@"ti"]) {
                currentFrame[@"ti"] = previousFrame[@"ti"];
            }
            if (keyframe[@"h"]) {
                currentFrame[@"h"] = keyframe[@"h"];
            }
            GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithKeyframe:currentFrame];
            [keys addObject:key];
            previousFrame = keyframe;
        }
        _keyframes= keys;
    } else {
        GhargeBranch_39 *key = [[GhargeBranch_39 alloc] initWithValue:data];
        _keyframes = @[key];
    }
    _nationalNumberPattern = [data decodeObjectForKey:@"nationalNumberPattern"];
    _possibleNumberPattern = [data decodeObjectForKey:@"possibleNumberPattern"];
    _possibleLengthLocalOnly = [data decodeObjectForKey:@"possibleLengthLocalOnly"];
    _exampleNumber = [data decodeObjectForKey:@"exampleNumber"];
    _nationalNumberMatcherData = [data decodeObjectForKey:@"nationalNumberMatcherData"];
    _possibleNumberMatcherData = [data decodeObjectForKey:@"possibleNumberMatcherData"];
    
    [data encodeObject:self.nationalNumberPattern forKey:@"nationalNumberPattern"];
    [data encodeObject:self.possibleNumberPattern forKey:@"possibleNumberPattern"];
    [data encodeObject:self.possibleLength forKey:@"possibleLength"];
    [data encodeObject:self.possibleLengthLocalOnly forKey:@"possibleLengthLocalOnly"];
    [data encodeObject:self.exampleNumber forKey:@"exampleNumber"];
    [data encodeObject:self.nationalNumberMatcherData forKey:@"nationalNumberMatcherData"];
    [data encodeObject:self.possibleNumberMatcherData forKey:@"possibleNumberMatcherData"];
    GhargeBranch_39 *other = data;
    [self.nationalNumberPattern isEqual:other.nationalNumberPattern] &&
    [self.possibleNumberPattern isEqual:other.possibleNumberPattern] &&
    [self.possibleLength isEqual:other.possibleLength] &&
    [self.possibleLengthLocalOnly isEqual:other.possibleLengthLocalOnly] &&
    [self.exampleNumber isEqual:other.exampleNumber] &&
    [self.nationalNumberMatcherData isEqualToData:other.nationalNumberMatcherData] &&
    [self.possibleNumberMatcherData isEqualToData:other.possibleNumberMatcherData];
}

@end
