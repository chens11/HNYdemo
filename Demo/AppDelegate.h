//
//  AppDelegate.h
//  Demo
//
//  Created by zqchen on 12/4/14.
//  Copyright (c) 2014 chenzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据模型对象
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久性存储区
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//上下文对象
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//初始化Core Data使用的数据库
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

//managedObjectModel的初始化赋值函数
-(NSManagedObjectModel *)managedObjectModel;

//managedObjectContext的初始化赋值函数
- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
