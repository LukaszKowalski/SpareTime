//
//  categoryContainer.m
//  Dupa
//
//  Created by Łukasz Kowalski on 13/03/15.
//  Copyright (c) 2015 Łukasz Kowalski. All rights reserved.
//

#import "categoryContainer.h"

@implementation categoryContainer

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *targetView = [self viewWithTag:69 ];
    // Convert the point to the target view's coordinate system.
    // The target view isn't necessarily the immediate subview
    CGPoint pointForTargetView = [targetView convertPoint:point fromView:self];
    
    if (CGRectContainsPoint(targetView.bounds, pointForTargetView)) {
        
        // The target view may have its view hierarchy,
        // so call its hitTest method to return the right hit-test view
        return [targetView hitTest:pointForTargetView withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}


@end
