

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SJIOSUserInfo.h"


@interface SJIOSDataBase : NSObject
{
     sqlite3 *_database;
}
@property (nonatomic) sqlite3 *_database;
-(BOOL) createSJIOSList:(sqlite3 *)db;//创建数据库
-(BOOL) insertSJIOSList:(SJIOSUserInfo *)insertList;//插入数据
-(BOOL) updateSJIOSTourist:(SJIOSUserInfo *)updateList;//更新数据
-(BOOL) updateSJIOSPassword:(NSString *) password userName:(NSString*) username;
-(NSMutableArray*)getTestList;//获取全部数据
- (BOOL) deleteSJIOSList:(NSString *)deletList;//删除数据：
- (BOOL)searchSJIOSUser:(NSString*)searchString;//查询数据库，searchID为要查询数据的ID，返回数据为查询到的数据
-(BOOL)updateSJIOSUserInfo:(SJIOSUserInfo*)updateSJIOSUserInfo;

- (BOOL)searchSJIOSBindUser:(NSString*)searchString;
@end


