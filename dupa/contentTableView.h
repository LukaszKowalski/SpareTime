//
//  contentTableView.h
//  Dupa
//
//  Created by Łukasz Kowalski on 3/22/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface contentTableView : UITableView

@property (strong, nonatomic) UIView *search;
@property (nonatomic, assign) BOOL cellOpened;
@property (nonatomic, strong) NSMutableArray *expandedPaths;
@property (nonatomic, strong) NSMutableSet *set_OpenIndex;
@property (nonatomic, strong) NSArray *cinemaNames;

@end
