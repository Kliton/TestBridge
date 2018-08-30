//  Created by react-native-create-bridge
#import <Foundation/Foundation.h>
#import "IosMathBridge.h"

// import RCTEventDispatcher
#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#elif __has_include(“RCTEventDispatcher.h”)
#import “RCTEventDispatcher.h”
#else
#import “React/RCTEventDispatcher.h” // Required when used as a Pod in a Swift project
#endif

#import "MTMathUILabel.h"



@implementation IosMathBridge : UIView  {
  RCTEventDispatcher *_eventDispatcher;
  UIView *_childView;
  NSString * _originalFormula;
}

@synthesize manager;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
  if ((self = [super init])) {
    _eventDispatcher = eventDispatcher;
    _childView = [[UIView alloc] init];
    _childView.backgroundColor = [UIColor blueColor];
  }

  return self;
}

- (void)layoutSubviews{
  [super layoutSubviews];
  _childView.frame = self.bounds;
  
  [self addSubview:_childView];
}

-(void)setFormula:(NSString *)prop {
  NSLog(@"Richiamo setFormula");

  if (![prop isEqual:_formula]){
    _formula = [prop copy];
    _originalFormula = _formula;
    [self setLatexFormula:_formula];
  }
}

-(void)setMaxWidth:(double)prop {
  NSLog(@"Richiamo setMaxWidth %f", prop);
    self._maxWidth = prop;
  [self setLatexFormula:_formula];

  
}


- (void)setLatexFormula:(NSString *)formula {
  NSLog(@"Formula settata", formula);

  MTMathUILabel* label = [[MTMathUILabel alloc] init];
  label.latex = formula;
  label.textColor=[UIColor whiteColor];
  [label sizeToFit];
  label.fontSize = 5;
  
  NSLog(@" inizio width = %f, maxWidth = %f, fontSize: %d",label.frame.size.width, label.fontSize);

//  if (self._maxWidth > 0) {
//    double width = label.frame.size.width;
//
//    while (width > self._maxWidth){
//      label.fontSize = label.fontSize -1;
//      [label setNeedsDisplay];
//
//      NSLog(@"width = %f, maxWidth = %f, fontSize: %d",width, self._maxWidth, label.fontSize);
//    }
//
//  }
  
  [_childView addSubview:label];
  [_childView setNeedsDisplay];

  NSLog(@"width = %f, height = %f", label.frame.size.width, label.frame.size.height);
  [self.manager publishDraggedEvent:label.frame.size.width :label.frame.size.height];

  
}

@end
