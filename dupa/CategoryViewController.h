//
//  ViewController.h
//  dupa
//
//  Created by Łukasz Kowalski on 03/02/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpareTimeCategoryButton.h"

@interface CategoryViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView *buttonIcon;
@property (strong, nonatomic) UIImageView *background;
@property (strong, nonatomic) UILabel *buttonName;
@property (strong, nonatomic) NSMutableDictionary *backgroundsWithTags;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

-(void)drawCategoryButtons;

@end

