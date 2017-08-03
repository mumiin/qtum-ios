//
//  AddressTransferPopupViewControllerLight.m
//  qtum wallet
//
//  Created by Vladimir Lebedevich on 02.08.17.
//  Copyright © 2017 PixelPlex. All rights reserved.
//

#import "AddressTransferPopupViewControllerLight.h"

@interface AddressTransferPopupViewControllerLight ()

@end

@implementation AddressTransferPopupViewControllerLight

-(UIPickerView*)createPickerView {
    
    UIPickerView* fromPicker = [[UIPickerView alloc] init];
    fromPicker.backgroundColor = [UIColor whiteColor];
    fromPicker.delegate = self;
    fromPicker.dataSource = self;
    fromPicker.showsSelectionIndicator = YES;
    return fromPicker;
}

- (UIToolbar*)createToolbar {
    
    UIToolbar* toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.translucent = NO;
    toolbar.barTintColor = [UIColor whiteColor];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", "") style:UIBarButtonItemStyleDone target:self action:@selector(endEditing)];
    doneButton.tintColor = lightGreenColor();
    toolbar.items = @[
                      [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                      doneButton];
    [toolbar sizeToFit];
    
    return toolbar;
}

-(UIView *)pickerView:(UIPickerView *)pickerView
           viewForRow:(NSInteger)row
         forComponent:(NSInteger)component
          reusingView:(UIView *)view {
    
    NSString* address = self.fromAddressesVariants.allKeys[row];
    NSString* amount = [NSString stringWithFormat:@"%@", self.fromAddressesVariants[address]];
    
    UIView* container;
    UILabel* amountLabel;
    UILabel* addressLabel;
    
    if(view == nil) {
        container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 30)];
        
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, pickerView.frame.size.width * 0.65, 30)];
        amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressLabel.frame.size.width + 10 + 20,
                                                                0,
                                                                pickerView.frame.size.width - addressLabel.frame.size.width - 10 -20,
                                                                30)];

        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.text = address;
        addressLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:14];
        addressLabel.textAlignment = NSTextAlignmentCenter;
        addressLabel.textColor = lightBlackColor();
        
        amountLabel.backgroundColor = [UIColor clearColor];
        amountLabel.text = amount;
        amountLabel.font = [UIFont fontWithName:@"ProximaNova-Semibold" size:16];
        amountLabel.textAlignment = NSTextAlignmentCenter;
        amountLabel.textColor = lightBlackColor();
        
        [container addSubview:amountLabel];
        [container addSubview:addressLabel];
    }
    
    return container;
}

@end
