//
//  AppDelegate.m
//  Demo
//
//  Created by zqchen on 12/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate()

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];
    self.window.windowLevel = UIWindowLevelStatusBar +100;
    self.window.backgroundColor = [UIColor clearColor];
    MainViewController *controller = [[MainViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window.windowLevel = UIWindowLevelNormal;
//    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"app recieve local notification /n %@",notification);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}

//这个方法定义的是当应用程序退到后台时将执行的方法，按下home键执行（通知中心来调度）
//实现此方法的目的是将托管对象上下文存储到数据存储区，防止程序退出时有未保存的数据
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext{
    if (!_managedObjectContext) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    }
    return _managedObjectContext;
}
//- (NSManagedObjectContext *)managedObjectContext
//{
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
//    
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if (coordinator != nil) {
//        _managedObjectContext = [[NSManagedObjectContext alloc] init];
//        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    }
//    return _managedObjectContext;
//}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel{
    if (!_managedObjectModel)
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return _managedObjectModel;
}

//- (NSManagedObjectModel *)managedObjectModel
//{
//    if (_managedObjectModel != nil) {
//        return _managedObjectModel;
//    }
//    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
//    return _managedObjectModel;
//}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator*)persistentStoreCoordinator{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"HNYTCoreData.sqlite"]];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:fileURL options:nil error:(&error)]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

//- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
//{
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
//    
//    //得到数据库的路径
//    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    //CoreData是建立在SQLite之上的，数据库名称需与Xcdatamodel文件同名
//    NSURL *storeUrl = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"HNYTCoreData.sqlite"]];
//    NSError *error = nil;
//
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        abort();
//    }    
//    
//    return _persistentStoreCoordinator;
//}
//
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
