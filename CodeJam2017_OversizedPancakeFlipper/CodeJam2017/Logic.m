//
//  Logic.m
//  CodeJam2017
//
//  Created by Gregory on 4/8/17.
//  Copyright © 2017 None. All rights reserved.
//

#import "Logic.h"

@implementation Logic

- (NSString *)processValidInput:(NSString *)inputString {
    NSMutableString *outputString = [NSMutableString new];
    
    NSArray *lines = [inputString componentsSeparatedByString:@"\n"];
    
    NSInteger T = [lines[0] integerValue];
    for (NSInteger t = 1; t <= T; ++t) {
        
        NSArray *parts = [lines[t] componentsSeparatedByString:@" "];
        NSInteger K = [parts[1] integerValue];
        NSInteger count = [parts[0] length];
        
        char *line = (char*)[parts[0] UTF8String];
        
        // flippity
        BOOL good = YES;
        int flipCount = 0;
        for (int i = 0; i <= count - K; ++i) {
            if (line[i] == '+') continue;
            flipCount++;
            
            for (int j = 0; j < K; ++j) {
                line[i+j] = [self flip:line[i+j]];
            }
            
            // check
            good = YES;
            for (int i = 0; i < count; ++i) {
                if (line[i] == '-') {
                    good = NO;
                    break;
                }
            }
            if (good) {
                break;
            }
        }
        
        good = YES;
        for (int i = 0; i < count; ++i) {
            if (line[i] == '-') {
                good = NO;
                break;
            }
        }
        
        if (good) {
            [outputString appendFormat:@"Case #%ld: %d\n", (long)t, flipCount];
        } else {
            [outputString appendFormat:@"Case #%ld: IMPOSSIBLE\n", (long)t];
        }
    }
    
    return outputString;
}

- (char)flip:(char)pancake {
    return pancake == '+' ? '-' : '+';
}

@end
