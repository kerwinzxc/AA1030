

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UnnHeTooUserInfo.h"

#define kFilename  @"testdb.db"

@interface UnnHeTooDataBase : NSObject
{
     sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;
-(BOOL) createUnnHeTooList:(sqlite3 *)db;//创建数据库
-(BOOL) insertUnnHeTooList:(UnnHeTooUserInfo *)insertList;//插入数据
-(BOOL) updateUnnHeTooTourist:(UnnHeTooUserInfo *)updateList;//更新数据
-(BOOL) updateUnnHeTooPassword:(NSString *) password userName:(NSString*) username;
-(NSMutableArray*)getTestList;//获取全部数据
- (BOOL) deleteUnnHeTooList:(NSString *)deletList;//删除数据：
- (BOOL)searchUnnHeTooUser:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(BOOL)updateUnnHeTooUserInfo:(UnnHeTooUserInfo*)updateUnnHeTooUserInfo;

- (BOOL)searchUnnHeTooBindUser:(NSString*)searchString;
@end


