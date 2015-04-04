//
//  TextFieldTableCell.h
//  WebBrowser
//
//  Created by Maximilian Litteral on 8/2/12.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

@import UIKit;

@class MLTextFieldFullTableViewCell;
@class MLTextFieldWithTitleTableViewCell;

@protocol MLTextFieldFullTableViewCellDelegate <NSObject>
@optional
- (void)cellDidBeginEditing:(MLTextFieldFullTableViewCell *)cell;
- (void)cellDidEndEditing:(MLTextFieldFullTableViewCell *)cell;

@end

@interface MLTextFieldFullTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<MLTextFieldFullTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) BOOL secure;

- (void)setTextFieldTextColor:(UIColor *)color UI_APPEARANCE_SELECTOR;

@end

@protocol MLTextFieldWithTitleTableViewCellDelegate <NSObject>
@optional
- (void)cellDidBeginEditing:(MLTextFieldWithTitleTableViewCell *)cell;
- (void)cellDidEndEditing:(MLTextFieldWithTitleTableViewCell *)cell;

@end

@interface MLTextFieldWithTitleTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<MLTextFieldWithTitleTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) BOOL secure;

- (void)setTitleLabelTextColor:(UIColor *)color UI_APPEARANCE_SELECTOR;
- (void)setTextFieldTextColor:(UIColor *)color UI_APPEARANCE_SELECTOR;

@end
