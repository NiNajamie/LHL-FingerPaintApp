//
//  DrawerView.m
//  LHL-FingerPaintApp
//
//  Created by Asuka Nakagawa on 2016-05-13.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

#import "DrawerView.h"

@interface DrawerView ()

 // creating new emptyArray for storing NSValue in the each line
@property (nonatomic) NSMutableArray *touches;

@end

@implementation DrawerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.touches = [NSMutableArray array];
    [self.touches addObject:[NSMutableArray array]];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    // context (like an empty paper)
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    CGContextFillRect(context, rect);
//    CGContextMoveToPoint(context, 10, 10);
//    CGContextSetLineWidth(context, 5);
//    CGContextAddLineToPoint(context, 100, 30);
//    CGContextStrokePath(context);
    
    //
    UIBezierPath *path = [UIBezierPath bezierPath];
    
        for (NSMutableArray *touchArray in self.touches) {
            if (touchArray.count > 0) {
                NSValue *firstValue = touchArray.firstObject;
                CGPoint firstPoint = firstValue.CGPointValue;
                [path moveToPoint:firstPoint];
                
                for (int i = 1; i < touchArray.count; i++) {
                    NSValue *nextValue = touchArray[i];
                    CGPoint nextPoint = nextValue.CGPointValue;
                    [path addLineToPoint:nextPoint];
                }
            }
        }
    path.lineWidth = 2;
    [path stroke];
}

// once if user remove his finger from paper, line ends
// and store the drawingPoints in the MutableArray
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.touches addObject:[NSMutableArray array]];
}

// each time user draws line, keep NSValue in the end of the array
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *move = [[event allTouches] anyObject];
    CGPoint MovePoint = [move locationInView:self];
    
    [self.touches.lastObject addObject:[NSValue valueWithCGPoint:MovePoint]];
    [self setNeedsDisplay];
}

@end
