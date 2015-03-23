//
//  uncollapsedTableViewCell.h
//  Dupa
//
//  Created by Łukasz Kowalski on 3/20/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface uncollapsedTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@property (weak, nonatomic) IBOutlet UILabel *cinemaName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *length;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *director;
@property (weak, nonatomic) IBOutlet UILabel *crew;
@property (weak, nonatomic) IBOutlet UILabel *textDescription;
@property (weak, nonatomic) IBOutlet UIButton *trailerButton;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end
