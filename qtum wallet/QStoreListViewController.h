//
//  QStoreListViewController.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 28.06.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QStoreListOutput.h"
#import "Presentable.h"
#import "QStoreListTableSource.h"

@interface QStoreListViewController : UIViewController <QStoreListOutput, Presentable>

@property (nonatomic) QStoreListTableSource *source;

@end
