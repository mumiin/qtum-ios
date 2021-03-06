//
//  CreateTokenFinishViewController.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 17.05.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContractCreationEndOutput.h"
@class ResultTokenInputsModel;

@protocol ContractCoordinatorDelegate;

@interface CreateTokenFinishViewController : BaseViewController <ContractCreationEndOutput>

@end
