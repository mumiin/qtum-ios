//
//  PinController.h
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 05.01.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTextField.h"

@interface PinController : BaseViewController

@property (weak, nonatomic) IBOutlet CustomTextField *firstSymbolTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *secondSymbolTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *thirdSymbolTextField;
@property (weak, nonatomic) IBOutlet CustomTextField *fourthSymbolTextField;
@property (weak, nonatomic) IBOutlet UIView *pinContainer;
@property (weak, nonatomic) IBOutlet UIView *incorrectPinView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstInputViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *secondInputViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thridInputViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fourthInputViewHeight;
@property (weak, nonatomic) IBOutlet UIView *firstInputUnderlineView;
@property (weak, nonatomic) IBOutlet UIView *secondInputUnderlineView;
@property (weak, nonatomic) IBOutlet UIView *thridInputUnderlineView;
@property (weak, nonatomic) IBOutlet UIView *fourthInputUnderlineView;
@property (assign,nonatomic,getter = isEditingEnabled) BOOL editingEnabled;

@property (weak,nonatomic) id <PinCoordinator> delegatePin;
@property (assign,nonatomic) PinType type;

- (void)actionIncorrectPin;
- (void)accessPinDenied;
- (void)clearPinTextFields;
- (void)redirectTextField:(UITextField*)textField isReversed:(BOOL) reversed;

@end
