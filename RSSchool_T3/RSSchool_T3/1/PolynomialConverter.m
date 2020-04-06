#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    
    NSInteger degreeOfX = numbers.count - 1;
    NSMutableString *finalString = [[NSMutableString alloc] init];
    
    if (degreeOfX < 0) {
        return nil;
    }
    
    for (int i = 0; i < numbers.count; i++) {
        int element = [numbers[i] intValue];
        int convertElement = abs(element);
        NSString *stringElement = [NSString stringWithFormat:@"%i", convertElement];
        NSString *stringDegreeOfX = [@(degreeOfX) stringValue];
        if (element != 0) {
            if (convertElement == 1) {
                if (element < 0) {
                    [finalString appendString:@"- "];
                    if (degreeOfX > 1) {
                        [finalString appendString:@"x"];
                        [finalString appendString:@"^"];
                        [finalString appendString:stringDegreeOfX];
                    } else {
                        if (degreeOfX == 1) {
                            [finalString appendString:@"x"];
                        }
                    }
                    [finalString appendString:@" "];
                } else {
                    [finalString appendString:@"+ "];
                    if (degreeOfX > 1) {
                        [finalString appendString:@"x"];
                        [finalString appendString:@"^"];
                        [finalString appendString:stringDegreeOfX];
                    } else {
                        if (degreeOfX == 1) {
                            [finalString appendString:@"x"];
                        }
                    }
                    [finalString appendString:@" "];
                }
            } else {
                if (element < 0) {
                    [finalString appendString:@"- "];
                    [finalString appendString:stringElement];
                    if (degreeOfX > 1) {
                        [finalString appendString:@"x"];
                        [finalString appendString:@"^"];
                        [finalString appendString:stringDegreeOfX];
                    } else {
                        if (degreeOfX == 1) {
                            [finalString appendString:@"x"];
                        }
                    }
                    [finalString appendString:@" "];
                } else {
                    [finalString appendString:@"+ "];
                    [finalString appendString:stringElement];
                    if (degreeOfX > 1) {
                        [finalString appendString:@"x"];
                        [finalString appendString:@"^"];
                        [finalString appendString:stringDegreeOfX];
                    } else {
                        if (degreeOfX == 1) {
                            [finalString appendString:@"x"];
                        }
                    }
                    [finalString appendString:@" "];
                }
            }
        }
        
        degreeOfX = degreeOfX - 1;
    }

    
    NSString *final = finalString;
    
    if ([final length] > 0) {
        final = [final substringFromIndex: 2];
        final = [final substringToIndex:[final length] - 1];
    }
    
    if ([numbers[0] intValue] < 0) {
        final = [@"-" stringByAppendingString:final];
    }
    
    return final;
}
@end
