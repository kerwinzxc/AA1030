

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "RersistenceUserInfo.h"

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

@interface RersistenceDataBase : NSObject
{
     sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;
-(BOOL) createRersistenceList:(sqlite3 *)db;//创建数据库
-(BOOL) insertRersistenceList:(RersistenceUserInfo *)insertList;//插入数据
-(BOOL) updateRersistenceTourist:(RersistenceUserInfo *)updateList;//更新数据
-(BOOL) updateRersistencePassword:(NSString *) password userName:(NSString*) username;
-(NSMutableArray*)getTestList;//获取全部数据
- (BOOL) deleteRersistenceList:(NSString *)deletList;//删除数据：
- (BOOL)searchRersistenceUser:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(BOOL)updateRersistenceUserInfo:(RersistenceUserInfo*)updateRersistenceUserInfo;

- (BOOL)searchRersistenceBindUser:(NSString*)searchString;
@end


