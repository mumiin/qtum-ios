//
//  QRCodeViewController.h
//  qtum wallet
//
//  Created by Sharaev Vladimir on 21.11.16.
//  Copyright © 2016 PixelPlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeManager.h"

@protocol QRCodeViewControllerDelegate <NSObject>

- (void)didQRCodeScannedWithSendInfoItem:(SendInfoItem *)item;
- (void)didBackPressed;

@end

@interface QRCodeViewController : BaseViewController

@property (nonatomic, weak) id<QRCodeViewControllerDelegate> delegate;

@end
