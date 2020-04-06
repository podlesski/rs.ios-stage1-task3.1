#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    
    int mutableValue = 1;
        int posters = [array[0] intValue];
        int colors = [array[1] intValue];
        
        long int factorial1 = [self findFactorialFromNumber:colors];
        
        while (mutableValue < colors) {
            long int factorial2 = [self findFactorialFromNumber:colors - mutableValue];
            long int factorial3 = [self findFactorialFromNumber:mutableValue];
            
            long int m = factorial3 * factorial2;
            
            long int result = factorial1/m;
            
            if (result == posters) {
                NSNumber *final = [NSNumber numberWithInt:mutableValue];
                
                return final;
            }
            
            mutableValue += 1;
            
        }
        
        return nil;
    }

    - (long int)findFactorialFromNumber:(int)number {
        int mutableValue = number;
        long int factorialValue = number;
        
        while (mutableValue > 1) {
            mutableValue -= 1;
            factorialValue = factorialValue * mutableValue;
        }
        
        return factorialValue;
}
@end
