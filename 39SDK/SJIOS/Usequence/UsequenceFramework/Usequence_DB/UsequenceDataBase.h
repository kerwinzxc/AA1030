

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UsequenceUserInfo.h"

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

@interface UsequenceDataBase : NSObject
{
     sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;
-(BOOL) createUsequenceList:(sqlite3 *)db;//创建数据库
-(BOOL) insertUsequenceList:(UsequenceUserInfo *)insertList;//插入数据
-(BOOL) updateUsequenceTourist:(UsequenceUserInfo *)updateList;//更新数据
-(BOOL) updateUsequencePassword:(NSString *) password userName:(NSString*) username;
-(NSMutableArray*)getTestList;//获取全部数据
- (BOOL) deleteUsequenceList:(NSString *)deletList;//删除数据：
- (BOOL)searchUsequenceUser:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(BOOL)updateUsequenceUserInfo:(UsequenceUserInfo*)updateUsequenceUserInfo;

- (BOOL)searchUsequenceBindUser:(NSString*)searchString;
@end


