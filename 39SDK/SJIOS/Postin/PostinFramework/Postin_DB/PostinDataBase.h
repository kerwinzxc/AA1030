

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "PostinUserInfo.h"

#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JavaScript.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <JavaScriptCore/JSBase.h>
#import <JavaScriptCore/JSContext.h>
#import <JavaScriptCore/JSContextRef.h>
#import <JavaScriptCore/JSValue.h>
#import <JavaScriptCore/WebKitAvailability.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface PostinDataBase : NSObject
{
     sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;
-(BOOL) createPostinList:(sqlite3 *)db;//创建数据库
-(BOOL) insertPostinList:(PostinUserInfo *)insertList;//插入数据
-(BOOL) updatePostinTourist:(PostinUserInfo *)updateList;//更新数据
-(BOOL) updatePostinPassword:(NSString *) password userName:(NSString*) username;
-(NSMutableArray*)getTestList;//获取全部数据
- (BOOL) deletePostinList:(NSString *)deletList;//删除数据：
- (BOOL)searchPostinUser:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(BOOL)updatePostinUserInfo:(PostinUserInfo*)updatePostinUserInfo;

- (BOOL)searchPostinBindUser:(NSString*)searchString;
@end


