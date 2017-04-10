//
//  Logic.m
//  CodeJam2017
//
//  Created by Gregory on 4/8/17.
//  Copyright © 2017 None. All rights reserved.
//

#import "Logic.h"

// [row][col]
//char t_sampleMatrix[4][4] = {
//    { '.', '.', '.', '.' },
//    { '+', '+', '+', '.' },
//    { 'x', '.', '.', '.' },
//    { '.', '.', '.', '.' }
//};

//char t_sampleMatrix[3][3] = {
//    { '.', '.', '.' },
//    { '+', '+', '+' },
//    { 'x', '.', '.' }
//};
//
//char *sampleMatrix = (char *)t_sampleMatrix;


@interface Logic ()
{
    char *originalMatrix;
    int m_elementsAdded;
    NSMutableString *m_elementsData;
}

@end

@implementation Logic

//- (NSString *)processValidInput:(NSString *)inputString {
//    int size = 3;
//    
//    [self printMatrix:sampleMatrix size:size];
//    NSLog(@"Validating matrix...");
//    NSLog(@"Matrix is %@", [self validateMatrix:sampleMatrix size:size] ? @"VALID" : @"INVALID");
//    NSLog(@"Matrix value is %ld", [self matrixValue:sampleMatrix size:size]);
//    
//    NSLog(@"Fixing matrix...");
//    [self fixMatrix:sampleMatrix size:size];
//    
//    [self printMatrix:sampleMatrix size:size];
//    NSLog(@"Validating matrix...");
//    NSLog(@"Matrix is %@", [self validateMatrix:sampleMatrix size:size] ? @"VALID" : @"INVALID");
//    NSLog(@"Matrix value is %ld", [self matrixValue:sampleMatrix size:size]);
//    
//    return nil;
//}

- (NSString *)processValidInput:(NSString *)inputString {
    NSMutableString *outputString = [NSMutableString new];
    
    NSArray *lines = [inputString componentsSeparatedByString:@"\n"];
    
    NSInteger T = [lines[0] integerValue];
    int lineIdx = 1;
    for (NSInteger t = 1; t <= T; ++t, ++lineIdx) {
        
        NSArray *parts = [lines[lineIdx] componentsSeparatedByString:@" "];
        int N = (int)[parts[0] integerValue];
        int M = (int)[parts[1] integerValue];
        
        char *matrix = malloc(sizeof(char) * N * N);
        memset(matrix, (int)'.', sizeof(char) * N * N);
        
        char *matrix2 = malloc(sizeof(char) * N * N);
        memset(matrix2, (int)'.', sizeof(char) * N * N);
        
        originalMatrix = malloc(sizeof(char) * N * N);
        memset(originalMatrix, (int)'.', sizeof(char) * N * N);
        
        if (M > 0) {
            for (int m = 0; m < M; ++m) {
                lineIdx++;
                NSArray *mParts = [lines[lineIdx] componentsSeparatedByString:@" "];
                char sym = [mParts[0] UTF8String][0];
                NSInteger row = [mParts[1] integerValue] - 1;
                NSInteger column = [mParts[2] integerValue] - 1;
                
                matrix[row*N + column] = sym;
                matrix2[row*N + column] = sym;
                originalMatrix[row*N + column] = sym;
            }
        }
        
//        NSLog(@"Initial matrix #%ld", (long)t);
//        [self printMatrix:matrix size:N];
        
        int value = 0;
        
        m_elementsAdded = 0;
        m_elementsData = [NSMutableString new];
        [self fixMatrix1:matrix size:N];
        int value1 = [self matrixValue:matrix size:N];
        int elementsAddedCopy = m_elementsAdded;
        NSMutableString *elementsDataCopy = [m_elementsData copy];
        
        m_elementsAdded = 0;
        m_elementsData = [NSMutableString new];
        [self fixMatrix2:matrix2 size:N];
        int value2 = [self matrixValue:matrix2 size:N];
        
        if (value1 > value2) {
            m_elementsAdded = elementsAddedCopy;
            m_elementsData = elementsDataCopy;
            value = value1;
//                    [self printMatrix:matrix size:N];
        } else {
            value = value2;
//                    [self printMatrix:matrix2 size:N];
        }
        
//        NSLog(@"Matrix #%ld is %@", t, [self validateMatrix:matrix size:N] ? @"valid" : @"INVALID");
        
//        NSLog(@"Fixed matrix #%ld", (long)t);
//        [self printMatrix:matrix size:N];
        
        // Output
//        int value = [self matrixValue:matrix size:N];
        [outputString appendFormat:@"Case #%ld: %d %d\n", t, value, m_elementsAdded];
        NSLog(@"Case #%ld: %d %d\n", t, value, m_elementsAdded);
        [outputString appendString:m_elementsData];
        NSLog(@"%@", m_elementsData);
        
        free(matrix);
        free(matrix2);
        free(originalMatrix); originalMatrix = nil;
    }
    
    return outputString;
}


#pragma mark - Main logic

- (void)fixMatrix1:(char*)matrix size:(int)size {
    
    // a2
    [self fixMatrixWithOPlusAndX:matrix size:size];
    
}

- (void)fixMatrix2:(char*)matrix size:(int)size {
    
    // a1
//    [self fixMatrixWithPlusAndX:matrix size:size];
//    [self fixMatrixWithO:matrix size:size];
    
    // a2
//    [self fixMatrixWithOPlusAndX:matrix size:size];
    
    // a3
//    [self fixMatrixWithPlus:matrix size:size];
//    [self fixMatrixWithX:matrix size:size];
//    [self fixMatrixWithO:matrix size:size];
    
    // a4 - fail
//    [self fixMatrixWithX:matrix size:size];
//    [self fixMatrixWithPlus:matrix size:size];
//    [self fixMatrixWithO:matrix size:size];
    
    // a5 - win (some fails)
    [self fixMatrixWithX:matrix size:size];
    [self fixMatrixWithO:matrix size:size];
    [self fixMatrixWithPlus:matrix size:size];

    // a6
//    [self fixMatrixWithPlus:matrix size:size];
//    [self fixMatrixWithO:matrix size:size];
//    [self fixMatrixWithX:matrix size:size];
    
    // a7 - fail
//    [self fixMatrixWithO:matrix size:size];
//    [self fixMatrixWithPlus:matrix size:size];
//    [self fixMatrixWithX:matrix size:size];
    
    // a8 - total fail
//    [self fixMatrixWithO:matrix size:size];
//    [self fixMatrixWithX:matrix size:size];
//    [self fixMatrixWithPlus:matrix size:size];
}

- (void)fixMatrixWithO:(char*)matrix size:(int)size {
    
    for (int r = size-1; r >= 0; --r) {
        for (int c = size-1; c >= 0; --c) {
            if (matrix[r*size + c] == 'o') continue;
            
            char oldValue = matrix[r*size + c];
            matrix[r*size + c] = 'o';
            
            if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                matrix[r*size + c] = oldValue;
            } else {
                if (originalMatrix[r*size + c] == oldValue) {
                    m_elementsAdded++;
                    [m_elementsData appendFormat:@"%c %d %d\n", 'o', r+1, c+1];
                }
            }
        }
    }
    
}

- (void)fixMatrixWithPlusAndX:(char*)matrix size:(int)size {
    
    for (int r = size-1; r >= 0; --r) {
        for (int c = size-1; c >= 0; --c) {
            if (matrix[r*size + c] != '.') continue;
            
            char oldValue = matrix[r*size + c];
            matrix[r*size + c] = '+';
            
            if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                matrix[r*size + c] = 'x';
                
                if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                    matrix[r*size + c] = oldValue;
                } else {
                    if (originalMatrix[r*size + c] == oldValue) {
                        m_elementsAdded++;
                        [m_elementsData appendFormat:@"%c %d %d\n", 'x', r+1, c+1];
                    }
                }
            } else {
                if (originalMatrix[r*size + c] == oldValue) {
                    m_elementsAdded++;
                    [m_elementsData appendFormat:@"%c %d %d\n", '+', r+1, c+1];
                }
            }
        }
    }
    
}

- (void)fixMatrixWithX:(char*)matrix size:(int)size {
    
    for (int r = size-1; r >= 0; --r) {
        for (int c = size-1; c >= 0; --c) {
            if (matrix[r*size + c] != '.') continue;
            
            char oldValue = matrix[r*size + c];
            matrix[r*size + c] = 'x';
            
            if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                matrix[r*size + c] = oldValue;
            } else {
                if (originalMatrix[r*size + c] == oldValue) {
                    m_elementsAdded++;
                    [m_elementsData appendFormat:@"%c %d %d\n", 'x', r+1, c+1];
                }
            }
        }
    }
    
}

- (void)fixMatrixWithPlus:(char*)matrix size:(int)size {
    
    for (int r = size-1; r >= 0; --r) {
        for (int c = size-1; c >= 0; --c) {
            if (matrix[r*size + c] != '.') continue;
            
            char oldValue = matrix[r*size + c];
            matrix[r*size + c] = '+';
            
            if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                matrix[r*size + c] = oldValue;
            } else {
                if (originalMatrix[r*size + c] == oldValue) {
                    m_elementsAdded++;
                    [m_elementsData appendFormat:@"%c %d %d\n", '+', r+1, c+1];
                }
            }
        }
    }
    
}

- (void)fixMatrixWithOPlusAndX:(char*)matrix size:(int)size {
    
    for (int r = size-1; r >= 0; --r) {
        for (int c = size-1; c >= 0; --c) {
            if (matrix[r*size + c] == 'o') continue;
            
            char oldValue = matrix[r*size + c];
            matrix[r*size + c] = 'o';
            
            if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                matrix[r*size + c] = oldValue;
                if (matrix[r*size + c] != '.') {
                    continue;
                }
                
                matrix[r*size + c] = '+';
                
                if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                    matrix[r*size + c] = 'x';
                    
                    if (![self validateMatrix:matrix size:size atR:r andC:c]) {
                        matrix[r*size + c] = oldValue;
                    } else {
                        if (originalMatrix[r*size + c] == oldValue) {
                            m_elementsAdded++;
                            [m_elementsData appendFormat:@"%c %d %d\n", 'x', r+1, c+1];
                        }
                    }
                } else {
                    if (originalMatrix[r*size + c] == oldValue) {
                        m_elementsAdded++;
                        [m_elementsData appendFormat:@"%c %d %d\n", '+', r+1, c+1];
                    }
                }
            } else {
                if (originalMatrix[r*size + c] == oldValue) {
                    m_elementsAdded++;
                    [m_elementsData appendFormat:@"%c %d %d\n", 'o', r+1, c+1];
                }
            }
        }
    }
    
}

- (BOOL)validateMatrix:(char*)matrix size:(int)size atR:(int)row andC:(int)col {
    // Row
    BOOL containsNonPlus = NO;
    for (int c = 0; c < size; ++c) {
        if (matrix[row*size + c] == '.') continue;
        if (matrix[row*size + c] != '+') {
            if (containsNonPlus) return NO;
            else containsNonPlus = YES;
        }
    }
    
    // Col
    containsNonPlus = NO;
    for (int r = 0; r < size; ++r) {
        if (matrix[r*size + col] == '.') continue;
        if (matrix[r*size + col] != '+') {
            if (containsNonPlus) return NO;
            else containsNonPlus = YES;
        }
    }
    
    // Diag right-down
    int r = row, c = col;
    while (r >= 1 && c >= 1) {
        r--;
        c--;
    }
    
    BOOL containsNonX = NO;
    for (; r >= 0 && r < size && c >= 0 && c < size;
         ++r, ++c)
    {
        if (matrix[r*size + c] == '.') continue;
        if (matrix[r*size + c] != 'x') {
            if (containsNonX) return NO;
            else containsNonX = YES;
        }
    }
    
    // Diag right-up
    r = row; c = col;
    while (r < size-1 && c >= 1) {
        r++;
        c--;
    }
    
    containsNonX = NO;
    for (; r >= 0 && r < size && c >= 0 && c < size;
         --r, ++c)
    {
        if (matrix[r*size + c] == '.') continue;
        if (matrix[r*size + c] != 'x') {
            if (containsNonX) return NO;
            else containsNonX = YES;
        }
    }
    
    return YES;
}

#pragma mark - Aux methods

- (void)printMatrix:(char*)matrix size:(int)size {
    for (int r = 0; r < size; ++r) {
        for (int c = 0; c < size; ++c) {
            printf("%c ", matrix[r*size + c]);
        }
        printf("\n");
    }
}

- (BOOL)validateMatrix:(char*)matrix size:(int)size {
    BOOL result = YES;
    result = [self validateRowsInMatrix:matrix size:size];
    if (!result) return NO;
    result = [self validateColsInMatrix:matrix size:size];
    if (!result) return NO;
    result = [self validateDiagsInMatrix:matrix size:size];
    return result;
}

- (BOOL)validateRowsInMatrix:(char*)matrix size:(int)size {
    for (int r = 0; r < size; ++r) {
        BOOL containsNonPlus = NO;
        for (int c = 0; c < size; ++c) {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != '+') {
                if (containsNonPlus) {
                    NSLog(@"Row %d is invalid", r+1);
                    return NO;
                } else {
                    containsNonPlus = YES;
                }
            }
        }
    }
    return YES;
}

- (BOOL)validateColsInMatrix:(char*)matrix size:(int)size {
    for (int c = 0; c < size; ++c) {
        BOOL containsNonPlus = NO;
        for (int r = 0; r < size; ++r) {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != '+') {
                if (containsNonPlus) {
                    NSLog(@"Col %d is invalid", c+1);
                    return NO;
                } else {
                    containsNonPlus = YES;
                }
            }
        }
    }
    return YES;
}

- (BOOL)validateDiagsInMatrix:(char*)matrix size:(int)size {
    int startC = 0;
    for (int startR = 0; startR < size; ++startR) {
        
        // Down-right
        BOOL containsNonX = NO;
        for (int r = startR, c = startC;
             r >= 0 && r < size && c >= 0 && c < size;
             ++r, ++c)
        {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != 'x') {
                if (containsNonX) {
                    NSLog(@"Diag [%d][%d] down-right is invalid", startR+1, startC+1);
                    return NO;
                } else {
                    containsNonX = YES;
                }
            }
        }
        
        // Up-right
        containsNonX = NO;
        for (int r = startR, c = startC;
             r >= 0 && r < size && c >= 0 && c < size;
             --r, ++c)
        {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != 'x') {
                if (containsNonX) {
                    NSLog(@"Diag [%d][%d] up-right is invalid", startR+1, startC+1);
                    return NO;
                } else {
                    containsNonX = YES;
                }
            }
        }
    }
    
    startC = size-1;
    for (int startR = 0; startR < size; ++startR) {
        // Down-left
        BOOL containsNonX = NO;
        for (int r = startR, c = startC;
             r >= 0 && r < size && c >= 0 && c < size;
             ++r, --c)
        {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != 'x') {
                if (containsNonX) {
                    NSLog(@"Diag [%d][%d] down-left is invalid", startR+1, startC+1);
                    return NO;
                } else {
                    containsNonX = YES;
                }
            }
        }
        
        // Up-left
        containsNonX = NO;
        for (int r = startR, c = startC;
             r >= 0 && r < size && c >= 0 && c < size;
             --r, --c)
        {
            if (matrix[r*size + c] == '.') continue;
            
            if (matrix[r*size + c] != 'x') {
                if (containsNonX) {
                    NSLog(@"Diag [%d][%d] up-left is invalid", startR+1, startC+1);
                    return NO;
                } else {
                    containsNonX = YES;
                }
            }
        }
    }
    
    return YES;
}

- (int)matrixValue:(char*)matrix size:(int)size {
    int value = 0;
    for (int c = 0; c < size; ++c) {
        for (int r = 0; r < size; ++r) {
            if (matrix[r*size + c] == 'x' || matrix[r*size + c] == '+') value += 1;
            if (matrix[r*size + c] == 'o') value += 2;
        }
    }
    return value;
}

@end
