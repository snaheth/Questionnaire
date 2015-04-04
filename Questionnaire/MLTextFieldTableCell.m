//
//  TextFieldTableCell.m
//  WebBrowser
//
//  Created by Maximilian Litteral on 8/2/12.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "MLTextFieldTableCell.h"

@implementation MLTextFieldFullTableViewCell

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(cellDidEndEditing:)]) {
        [self.delegate cellDidBeginEditing:self];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(cellDidEndEditing:)]) {
        [self.delegate cellDidEndEditing:self];
    }
}

#pragma mark - Setters

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
}

- (void)setSecure:(BOOL)secure {
    _secure = secure;
    _textField.secureTextEntry = secure;
}

- (void)setTextFieldTextColor:(UIColor *)color {
    _textField.textColor = color;
}

#pragma mark - Setup

- (void)setupTextField {
    _textField = [[UITextField alloc] init];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    if (_placeholder) {
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeholder attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    }
    _textField.tintColor = [UIColor colorWithRed:0.146 green:0.612 blue:0.821 alpha:1.000];
    [self.contentView addSubview:_textField];
    
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:15.0f];
    [constraint setPriority:999];
    [constraints addObject:constraint];
    
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-15.0f];
    [constraint2 setPriority:999];
    [constraints addObject:constraint2];
    
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-8.0];
    [constraint3 setPriority:999];
    [constraints addObject:constraint3];
    
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:8.0];
    [constraint4 setPriority:999];
    [constraints addObject:constraint4];
    
    
    [self.contentView addConstraints:constraints];
}

#pragma mark - Cell Lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textLabel.text = @"";
    self.textField.text = @"";
    self.textField.placeholder = @"";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    [self setupTextField];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        [self setupTextField];
        
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        [constraint setPriority:999];
        [self.contentView addConstraint:constraint];
    }
    return self;
}

@end

@implementation MLTextFieldWithTitleTableViewCell
{
    NSLayoutConstraint *titleLabelWidthConstraint;
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.delegate cellDidBeginEditing:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate cellDidEndEditing:self];
}

#pragma mark - Setters

- (void)setText:(NSString *)text {
    _text = text;
    _titleLabel.text = text;
    [_titleLabel sizeToFit];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
//    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: [[MLThemeManager sharedTheme] textFieldTableCellPlaceholderForegroundColor]}];
}

- (void)setSecure:(BOOL)secure {
    _secure = secure;
    _textField.secureTextEntry = secure;
}

- (void)setTitleLabelTextColor:(UIColor *)color {
    _titleLabel.textColor = color;
}

- (void)setTextFieldTextColor:(UIColor *)color {
    _textField.textColor = color;
}

#pragma mark - Setup

- (void)setupTextField {
    _textField = [[UITextField alloc] init];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.delegate = self;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.textAlignment = NSTextAlignmentRight;
    if (_placeholder) {
//        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_placeholder attributes:@{NSForegroundColorAttributeName: [[MLThemeManager sharedTheme] textFieldTableCellPlaceholderForegroundColor]}];
    }
    [self.contentView addSubview:_textField];
    
    [_textField setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [_textField setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    // Leading
    NSMutableArray *constraints = [[NSMutableArray alloc] init];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:23.0f]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:_textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
    [self.contentView addConstraints:constraints];
}

#pragma mark - Cell Lifecycle

- (void)prepareForReuse {
    [super prepareForReuse];
    _titleLabel.text = @"";
    _textField.text = @"";
    _textField.placeholder = @"";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupTextField];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _titleLabel.text = _text;
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self setupTextField];
        
        NSMutableArray *constraints = [[NSMutableArray alloc] init];
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]-5-[_textField]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel, _textField)]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        [self.contentView addConstraints:constraints];

        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        [heightConstraint setPriority:999];
        [self.contentView addConstraint:heightConstraint];

    }
    return self;
}

- (void)dealloc {
    _textField = nil;
}

@end
