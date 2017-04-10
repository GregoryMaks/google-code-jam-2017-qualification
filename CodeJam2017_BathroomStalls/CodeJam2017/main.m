//
//  main.m
//  CodeJam2016_CountingSheeps
//
//  Created by GregoryM on 4/9/16.
//  Copyright © 2016 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logic.h"

//static NSString * const kInputFilename = @"Input.txt";
//static NSString * const kOutputFilename = @"Output.txt";

//static NSString * const kInputFilename = @"InputSmall.txt";
//static NSString * const kOutputFilename = @"OutputSmall.txt";

static NSString * const kInputFilename = @"InputLarge.txt";
static NSString * const kOutputFilename = @"OutputLarge.txt";


NSString* parseInputString(int argc, const char * argv[]);
BOOL writeOutputToFile(int argc, const char * argv[], NSString *outputString);
NSString* processInputString(NSString *inputString);


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *inputString = parseInputString(argc, argv);
        if (inputString == nil || inputString.length == 0) {
            NSLog(@"wrong input");
            return 1;
        }
        
        NSLog(@">>>>> Output Begins <<<<<< ");
        
        NSString *outputString = [[Logic new] processValidInput:inputString];
        
        NSLog(@"%@", outputString);
        NSLog(@">>>>> Output Ends <<<<<< ");
        
        if (!writeOutputToFile(argc, argv, outputString)) {
            NSLog(@"unable to save output");
        }
    }
    return 0;
}

NSString* parseInputString(int argc, const char * argv[]) {
    if (argc < 2) { return nil; }
    
    NSString *folderPath = [NSString stringWithUTF8String:argv[1]];
    
    NSString *inputString = [NSString stringWithContentsOfFile:[folderPath stringByAppendingPathComponent:kInputFilename]
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
    
    return inputString;
}

BOOL writeOutputToFile(int argc, const char * argv[], NSString *outputString) {
    if (argc < 2) { return NO; }
    
    NSString *folderPath = [NSString stringWithUTF8String:argv[1]];
    
    return [outputString writeToFile:[folderPath stringByAppendingPathComponent:kOutputFilename]
                          atomically:YES
                            encoding:NSUTF8StringEncoding
                               error:nil];
}
