//
//  SkyView.h
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SkyView;

@protocol SkyFallProtocol <NSObject>

- (void)skyViewTapped:(SkyView *)skyView;

@end

@interface SkyView : UIView

@property (nonatomic, weak) id<SkyFallProtocol> delegate;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
-(instancetype)init;
@end
