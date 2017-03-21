//
//  ControllersFactory.m
//  qtum wallet
//
//  Created by Никита Федоренко on 26.12.16.
//  Copyright © 2016 Designsters. All rights reserved.
//

#import "ControllersFactory.h"
#import "SendNavigationCoordinator.h"
#import "NewsNavigationController.h"
#import "ProfileNavigationCoordinator.h"
#import "UIViewController+Extension.h"
#import "TabBarController.h"
#import "WalletNameViewController.h"
#import "LoginViewController.h"
#import "FirstAuthViewController.h"
#import "RestoreWalletViewController.h"
#import "CreatePinViewController.h"
#import "RepeateViewController.h"
#import "AuthNavigationController.h"
#import "ExportWalletBrandKeyViewController.h"
#import "SubscribeTokenViewController.h"
#import "CreateTokenStep1ViewController.h"
#import "CreateTokenStep2ViewController.h"
#import "CreateTokenStep3ViewController.h"
#import "CreateTokenStep4ViewController.h"
#import "HistoryViewController.h"
#import "WalletNavigationController.h"


@implementation ControllersFactory

+ (instancetype)sharedInstance
{
    static ControllersFactory *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] initUniqueInstance];
    });
    return instance;
}

- (instancetype)initUniqueInstance
{
    self = [super init];
    if (self != nil) { }
    return self;
}

-(UIViewController*)sendFlowTab{
    UIViewController* controller = [UIViewController controllerInStoryboard:@"Send" withIdentifire:nil];
    SendNavigationCoordinator* nav = [[SendNavigationCoordinator alloc] initWithRootViewController:controller];
    return nav;
}

-(UIViewController*)profileFlowTab{
    UIViewController* controller = [UIViewController controllerInStoryboard:@"Profile" withIdentifire:nil];
    ProfileNavigationCoordinator* nav = [[ProfileNavigationCoordinator alloc] initWithRootViewController:controller];
    return nav;
}

-(UIViewController*)newsFlowTab{
    UIViewController* controller = [UIViewController controllerInStoryboard:@"News" withIdentifire:nil];
    NewsNavigationController* nav = [[NewsNavigationController alloc] initWithRootViewController:controller];
    return nav;
}

-(UIViewController*)createTabFlow{
    TabBarController* tabBar = [TabBarController new];
    return tabBar;
}


-(UINavigationController*)walletFlowTab{
    HistoryViewController* controller = (HistoryViewController*)[UIViewController controllerInStoryboard:@"Wallet" withIdentifire:nil];
    WalletNavigationController* nav = [[WalletNavigationController alloc] initWithRootViewController:controller];
    return nav;
}

-(WalletNameViewController*)createWalletNameCreateController{
    WalletNameViewController* controller = (WalletNameViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"WalletNameViewController"];
    return controller;
}

-(LoginViewController*)createLoginController{
    LoginViewController* controller = (LoginViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"LoginViewController"];
    return controller;
}

-(FirstAuthViewController*)createFirstAuthController{
    FirstAuthViewController* controller = (FirstAuthViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"FirstAuthViewController"];
    return controller;
}

-(RestoreWalletViewController*)createRestoreWalletController{
    RestoreWalletViewController* controller = (RestoreWalletViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"RestoreWalletViewController"];
    return controller;
}

-(CreatePinViewController*)createCreatePinController{
    CreatePinViewController* controller = (CreatePinViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"CreatePinViewController"];
    return controller;
}

-(RepeateViewController*)createRepeatePinController{
    RepeateViewController* controller = (RepeateViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"RepeateViewController"];
    return controller;
}

-(AuthNavigationController*)createAuthNavigationController{
    AuthNavigationController* controller = [[AuthNavigationController alloc]init];
    return controller;
}

-(ExportWalletBrandKeyViewController*)createExportWalletBrandKeyViewController{
    ExportWalletBrandKeyViewController* controller = (ExportWalletBrandKeyViewController*)[UIViewController controllerInStoryboard:@"Start" withIdentifire:@"ExportWalletBrandKeyViewController"];
    return controller;
}

-(SubscribeTokenViewController*)createSubscribeTokenViewController{
    SubscribeTokenViewController* controller = (SubscribeTokenViewController*)[UIViewController controllerInStoryboard:@"SubscribeToken" withIdentifire:@"SubscribeTokenViewController"];
    return controller;
}

-(CreateTokenStep3ViewController*)createCreateTokenStep3ViewController{
    CreateTokenStep3ViewController* controller = (CreateTokenStep3ViewController*)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"CreateTokenStep3ViewController"];
    return controller;
}

-(CreateTokenStep2ViewController*)createCreateTokenStep2ViewController{
    CreateTokenStep2ViewController* controller = (CreateTokenStep2ViewController*)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"CreateTokenStep2ViewController"];
    return controller;
}

-(CreateTokenStep1ViewController*)createCreateTokenStep1ViewController{
    CreateTokenStep1ViewController* controller = (CreateTokenStep1ViewController*)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"CreateTokenStep1ViewController"];
    return controller;
}

-(CreateTokenStep4ViewController*)createCreateTokenStep4ViewController{
    CreateTokenStep4ViewController* controller = (CreateTokenStep4ViewController*)[UIViewController controllerInStoryboard:@"CreateToken" withIdentifire:@"CreateTokenStep4ViewController"];
    return controller;
}

-(UIViewController*)createFlowNavigationCoordinator{
    return nil;
}

-(UIViewController*)createPinFlowController{
    return nil;
}

-(UIViewController*)createWalletFlowController{
    return nil;
}

-(UIViewController*)changePinFlowController{
    return nil;
}





@end