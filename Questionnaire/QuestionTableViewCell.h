//
//  QuestionTableViewCell.h
//  Questionnaire
//
//  Created by Maximilian Litteral on 4/4/15.
//  Copyright (c) 2015 Maximilian Litteral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *questionPreviewLabel;
@property (nonatomic, strong) UILabel *userTitleLabel;
@property (nonatomic, strong) UILabel *commentsLabel;

@end
