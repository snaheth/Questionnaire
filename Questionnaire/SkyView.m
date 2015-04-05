//
//  SkyView.m
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import "SkyView.h"

@implementation SkyView

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _imageView = [[UIImageView alloc] init];
        _imageView.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_imageView];
        
        [_imageView setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisHorizontal];
        [_imageView setContentHuggingPriority:1000 forAxis:UILayoutConstraintAxisVertical];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:24];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
        [self addSubview:_titleLabel];
        
        NSMutableArray *constraints = [[NSMutableArray alloc] init];
        NSDictionary *views = @{
                                @"_imageView": _imageView,
                                @"_titleLabel": _titleLabel,
                                };
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_imageView]-15-[_titleLabel]|" options:0 metrics:nil views:views]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [constraints addObject:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
        [self addConstraints:constraints];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
    }
    return self;
}

- (void)onTap:(UITapGestureRecognizer *)tapGesture {
    if ([self.delegate respondsToSelector:@selector(skyViewTapped:)]) {
        [self.delegate skyViewTapped:self];
    }
}

@end
