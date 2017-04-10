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
        NSString *Nstr = parts[0];
        NSString *Kstr = parts[1];
        
        long long n = [Nstr longLongValue];
        long long k = [Kstr longLongValue];
        
        long long e = n - k + 1;
        long double d = floorl(log2l((long double)k));
        long long m = ceill((long double)e / powl(2, d));
        
        //NSLog(@"%lld", m);
        
        m --;
        
        long long right = (m / 2);
        long long left = m - right;
        
        // Oneliner :)
//        long long m = ceill((long double)(n - k + 1) / powl(2, floorl(log2l((long double)k))));
//        
//        long long right = (m / 2);
//        long long left = m - right;
        
        
        
        [outputString appendFormat:@"Case #%ld: %lld %lld\n", t, left, right];
    }
    
    return outputString;
}

@end
