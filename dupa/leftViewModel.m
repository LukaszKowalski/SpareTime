//
//  leftViewModel.m
//  Dupa
//
//  Created by Łukasz Kowalski on 13/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "leftViewModel.h"

@implementation leftViewModel

static leftViewModel *sharedBarInstance = nil;    // static instance variable

+ (leftViewModel *)sharedInstance {
    if (sharedBarInstance == nil) {
        sharedBarInstance = [[super allocWithZone:NULL] init];
    }
    return sharedBarInstance;
}

- (id)init {
    if ( (self = [super init]) ) {
        // your custom initialization
    }
    return self;
}
- (void)sideBarCategory:(NSString *)categoryName{
    self.currentCategory = categoryName;
    NSLog(@"singleton category = %@", self.currentCategory);
}

- (NSString *)getSideBarCategory{
    return self.currentCategory;
}




@end
