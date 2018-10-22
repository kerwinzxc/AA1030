

#import "UnnHeTooDataBase.h"

@interface UnnHeTooDataBase()
@property(strong,nonatomic)UnnHeTooUserInfo *userinfo;

@end
@implementation UnnHeTooDataBase
@synthesize _database;

- (id)init
{
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    return [documentsDirectory stringByAppendingPathComponent:@"UnnHeToo.db"];
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    if (find) {
        
      
        
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
        //Objective-C)编写的，它不知道什么是NSString.
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
         
            return NO;
        }
        
        //创建一个新表
        [self createUnnHeTooList:self._database];
        
        return YES;
    }
    //如果发现数据库不存在则利用sqlite3_open创建数据库（上面已经提到过），与上面相同，路径要转换为C字符串
    if(sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        //创建一个新表
        [self createUnnHeTooList:self._database];
        return YES;
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(self._database);
       
        return NO;
    }
    return NO;
}

//创建表
- (BOOL) createUnnHeTooList:(sqlite3*)db {
    
    //这句是大家熟悉的SQL语句
    char *sql = "create table if not exists UnnHeToouserinfo(ID INTEGER PRIMARY KEY AUTOINCREMENT, username text,password text, bind text,tourist text,logintime text, phonenumber text)";
    
    sqlite3_stmt *statement;
    //sqlite3_prepare_v2 接口把一条SQL语句解析到statement结构里去. 使用该接口访问数据库是当前比较好的的一种方法
    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
    //第一个参数跟前面一样，是个sqlite3 * 类型变量，
    //第二个参数是一个 sql 语句。
    //第三个参数我写的是-1，这个参数含义是前面 sql 语句的长度。如果小于0，sqlite会自动计算它的长度（把sql语句当成以\0结尾的字符串）。
    //第四个参数是sqlite3_stmt 的指针的指针。解析以后的sql语句就放在这个结构里。
    //第五个参数是错误信息提示，一般不用,为nil就可以了。
    //如果这个函数执行成功（返回值是 SQLITE_OK 且 statement 不为NULL ），那么下面就可以开始插入二进制数据。
    
    
    //如果SQL语句解析出错的话程序返回
    if(sqlReturn != SQLITE_OK) {
        
        return NO;
    }
    
    //执行SQL语句
    int success = sqlite3_step(statement);
    //释放sqlite3_stmt
    sqlite3_finalize(statement);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        
        return NO;
    }
    
    return YES;
}

//插入数据
-(BOOL) insertUnnHeTooList:(UnnHeTooUserInfo *)insertList {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        //这个 sql 语句特别之处在于 values 里面有个? 号。在sqlite3_prepare函数里，?号表示一个未定的值，它的值等下才插入。
        static char *sql = "INSERT INTO UnnHeToouserinfo(username, password,bind,tourist,logintime,phonenumber) VALUES(?, ?, ?, ?, ?, ?)";
        
        int success2 = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success2 != SQLITE_OK) {
            
            sqlite3_close(_database);
            return NO;
        }
        
        //这里的数字1，2，3代表上面的第几个问号，这里将三个值绑定到三个绑定变量
        sqlite3_bind_text(statement, 1,  [insertList.username UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [insertList.password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [insertList.bind UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [insertList.tourist UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [insertList.loginTime UTF8String],-1,SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [insertList.phoneNumber UTF8String], -1, SQLITE_TRANSIENT);
      
        //执行插入语句
        success2 = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果插入失败
        if (success2 == SQLITE_ERROR) {
            
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//获取数据
- (NSMutableArray*)getTestList{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT *FROM UnnHeToouserinfo";//从testTable这个表中获取 testID, testValue ,testName，若获取全部的话可以用*代替testID, testValue ,testName。
        
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            
            return NO;
        }
        else {
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值,注意这里的列值，跟上面sqlite3_bind_text绑定的列值不一样！一定要分开，不然会crash，只有这一处的列号不同，注意！
            while (sqlite3_step(statement) == SQLITE_ROW) {
                UnnHeTooUserInfo* sqlList = [[UnnHeTooUserInfo alloc] init] ;
                char* username   = (char*)sqlite3_column_text(statement, 1);
                sqlList.username = [NSString stringWithUTF8String:username];
                char* password   = (char*)sqlite3_column_text(statement, 2);
                sqlList.password = [NSString stringWithUTF8String:password];
                char* bind   = (char*)sqlite3_column_text(statement, 3);
                sqlList.bind = [NSString stringWithUTF8String:bind];
                char *tourist = (char*)sqlite3_column_text(statement, 4);
                sqlList.tourist = [NSString stringWithUTF8String:tourist];
                char* loginTime=(char*)sqlite3_column_text(statement, 5);
                sqlList.loginTime   = [NSString stringWithUTF8String:loginTime];
                char* phonenumber=(char*)sqlite3_column_text(statement, 6);
                sqlList.phoneNumber   = [NSString stringWithUTF8String:phonenumber];
                [array addObject:sqlList];
                [sqlList release];
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return [array retain];//定义了自动释放的NSArray，这样不是个好办法，会造成内存泄露，建议大家定义局部的数组，再赋给属性变量。
}
//根据用户名更新数据
-(BOOL)updateUnnHeTooUserInfo:(UnnHeTooUserInfo*)updateUnnHeTooUserInfo{
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update UnnHeToouserinfo set  logintime = ? , password = ? WHERE username = ?";
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            
            sqlite3_close(_database);
            return NO;
        }
        
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对比较简单的数据库操作，真正的项目中会远远比这个复杂
        //绑定text类型的数据库数据
        sqlite3_bind_text(statement, 1, [updateUnnHeTooUserInfo.loginTime UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [updateUnnHeTooUserInfo.password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [updateUnnHeTooUserInfo.username UTF8String], -1, SQLITE_TRANSIENT);
      
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;

}
//更新数据
-(BOOL) updateUnnHeTooTourist:(UnnHeTooUserInfo *)updateList{
    
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update UnnHeToouserinfo set username = ? , password = ? ,bind = ?, logintime = ? ,phonenumber = ? WHERE tourist = ?";
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            
            sqlite3_close(_database);
            return NO;
        }
        
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对比较简单的数据库操作，真正的项目中会远远比这个复杂
        //绑定text类型的数据库数据
        sqlite3_bind_text(statement, 1, [updateList.username UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [updateList.password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 3, [updateList.bind UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 6, [updateList.tourist UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 4, [updateList.loginTime UTF8String],-1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [updateList.phoneNumber UTF8String],-1, SQLITE_TRANSIENT);
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            //关闭数据库

            sqlite3_close(_database);
            return NO;
        }

        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}
-(BOOL) updateUnnHeTooPassword:(NSString *)password userName:(NSString *)username
{
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update UnnHeToouserinfo set  password = ? WHERE username = ?";
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
           
            sqlite3_close(_database);
            return NO;
        }
        
        //这里的数字1，2，3代表第几个问号。这里只有1个问号，这是一个相对比较简单的数据库操作，真正的项目中会远远比这个复杂
        //绑定text类型的数据库数据
        sqlite3_bind_text(statement, 1, [password UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [username UTF8String], -1, SQLITE_TRANSIENT);
        
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;

}


//删除数据
- (BOOL) deleteUnnHeTooList:(NSString *)deletList{
    if ([self openDB]) {
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "delete from UnnHeToouserinfo  where username = ?";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
           
            sqlite3_close(_database);
            return NO;
        }
        sqlite3_bind_text(statement, 1, [deletList UTF8String], -1, SQLITE_TRANSIENT);
      
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
           
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
    
}
//查询数据
- (BOOL)searchUnnHeTooUser:(NSString*)searchString{
        NSMutableArray *array=[NSMutableArray array];
    //判断数据库是否打开
    if ([self openDB]) {
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * from UnnHeToouserinfo where username = ?"];
        const char *sql = [querySQL UTF8String];
        //        char *sql = "SELECT * FROM testTable WHERE testName like ?";//这里用like代替=可以执行模糊查找，原来是"SELECT * FROM testTable WHERE testName = ?"
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
           
            return NO;
        } else {
            //            sqlite3_bind_int(statement, 1, searchID);
            sqlite3_bind_text(statement, 1, [searchString UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* username   = (char*)sqlite3_column_text(statement, 1);
                NSString* name = [NSString stringWithUTF8String:username];
                [array addObject:name];
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    if ([array count]>0) {
        return YES;
    }
    return NO;
}


//查询数据
- (BOOL)searchUnnHeTooBindUser:(NSString *)searchString{
    NSMutableArray *array=[NSMutableArray array];
    //判断数据库是否打开
    if ([self openDB]) {
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * from UnnHeToouserinfo where tourist = ?"];
        const char *sql = [querySQL UTF8String];
        //        char *sql = "SELECT * FROM testTable WHERE testName like ?";//这里用like代替=可以执行模糊查找，原来是"SELECT * FROM testTable WHERE testName = ?"
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
           
            return NO;
        } else {
            //            sqlite3_bind_int(statement, 1, searchID);
            sqlite3_bind_text(statement, 1, [searchString UTF8String], -1, SQLITE_TRANSIENT);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char* username   = (char*)sqlite3_column_text(statement, 1);
                NSString* name = [NSString stringWithUTF8String:username];
                [array addObject:name];
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    if ([array count]>0) {
        return YES;
    }
    return NO;
}
@end


