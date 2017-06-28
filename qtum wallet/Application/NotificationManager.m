//
//  RemoutNotificationManager.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 21.03.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "NotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import "NSUserDefaults+Settings.h"
@import Firebase;
@import FirebaseMessaging;
@import UserNotifications;
@import FirebaseInstanceID;

@interface NotificationManager () <UNUserNotificationCenterDelegate,UIApplicationDelegate>

@end

@implementation NotificationManager

- (void)registerForRemoutNotifications {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if(!error){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    } else {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    [FIRApp configure];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:) name:kFIRInstanceIDTokenRefreshNotification object:nil];
}


-(void)removeToken {
    [NSUserDefaults saveDeviceToken:nil];
}

- (NSString*)getToken {
    return [NSUserDefaults getDeviceToken];
}

- (NSString*)getPrevToken {
    return [NSUserDefaults getPrevDeviceToken];
}

#pragma mark - UNUserNotificationCenterDelegate

//Called when a notification is delivered to a foreground app.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    completionHandler();
}

#pragma mark - AppDelegate

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *) deviceToken {
    
    [[FIRInstanceID instanceID] setAPNSToken:deviceToken type:FIRInstanceIDAPNSTokenTypeSandbox];
    [self storeDeviceToken];
}

- (void)registerForPushNotifications {
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@"PUSH NOTIFICATION : %@", userInfo);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"didFailToRegisterForRemoteNotificationsWithError : %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [[FIRMessaging messaging] appDidReceiveMessage:userInfo];
}

#pragma mark - Private Methods

-(void)storeDeviceToken{
    
    NSString* token = [[FIRInstanceID instanceID] token];
    NSString* prevToken = [NSUserDefaults getDeviceToken];
    [NSUserDefaults saveDeviceToken:token];
    [NSUserDefaults savePrevDeviceToken:([prevToken isEqualToString:token]) ? @"" : prevToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)createLocalNotificationWithString:(NSString*) text andIdentifire:(NSString*)identifire {
    
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(@"10.0")) {
        
        UNMutableNotificationContent* content = [UNMutableNotificationContent new];
        content.title = @"Local Notification";
        content.subtitle = @"QTUM";
        content.body = text;
        
        UNTimeIntervalNotificationTrigger* triger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:identifire content:content trigger:triger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    } else {
        UILocalNotification* notification = [UILocalNotification new];
        notification.alertBody = text;
        notification.alertTitle = @"Local Notification";
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

- (void)tokenRefreshNotification:(NSNotification *)notification {
    
    [self connectToFcm];
}

- (void)connectToFcm {
    
    __weak __typeof(self)weakSelf = self;
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Unable to connect to FCM. %@", error);
        } else {
            
            //NSLog(@"InstanceID_connectToFcm = %@", InstanceID);
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf storeDeviceToken];
                    [[WalletManager sharedInstance] startObservingForAllSpendable];
                    [[ContractManager sharedInstance] startObservingForAllSpendable];
                });
            });
        }
    }];
}


@end
