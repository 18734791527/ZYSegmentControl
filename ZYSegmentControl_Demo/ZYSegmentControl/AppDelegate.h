//
//  AppDelegate.h
//  ZYSegmentControl
//
//  Created by 赵言 on 2018/6/3.
//  Copyright © 2018年 赵言. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

