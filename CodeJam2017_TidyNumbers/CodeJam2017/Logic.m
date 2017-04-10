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
        char *line = (char*)[lines[t] UTF8String];
        
        while (true) {
            int i = [self findGapIndex:line];
            if (i == -1) {
                break;
            }
            
            [self fixGapIn:line at:i];
        }
        
        // trim to get rid of trailing 0s
        int i = 0;
        while (line[i] == '0') {
            ++i;
        }
        
        [outputString appendFormat:@"Case #%ld: %s\n", t, line+i];
    }
    
    return outputString;
}

- (int)findGapIndex:(char *)str {
    int i = 0;
    while (str[i] != '\0' && str[i+1] != '\0' &&
           str[i] != '\r' && str[i+1] != '\r')
    {
        if (str[i] > str[i+1]) {
            return i;
        }
        ++i;
    }
    return -1;
}

- (void)fixGapIn:(char *)str at:(int)gapIndex {
    str[gapIndex] --;
    
    int i = gapIndex + 1;
    while (str[i] != '\0' && str[i] != '\r') {
        str[i] = '9';
        ++i;
    }
}

@end
