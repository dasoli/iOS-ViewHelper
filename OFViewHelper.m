//
//  OFViewHelper.h
//
//  Created by Oliver Franke on 17.04.14.
//  Copyright (c) 2014 Oliver Franke. All rights reserved.
//


#import "OFViewHelper.h"
// comment in, if you want to support TTTAttributedLabel
// #import "TTTAttributedLabel.h"
// see codeline 770

@implementation OFViewHelper

//----------------------------------------------------------------------
CGRect CGRectIntegralScaledEx(CGRect rect,
                              CGFloat scale)
//----------------------------------------------------------------------
{
    return CGRectMake(floorf(rect.origin.x * scale) / scale,
                      floorf(rect.origin.y * scale) / scale,
                      ceilf(rect.size.width * scale) / scale,
                      ceilf(rect.size.height * scale) / scale);
}

CGRect CGRectIntegralScaled(CGRect rect)
{
    return CGRectIntegralScaledEx(rect, [[UIScreen mainScreen] scale]);
}

//----------------------------------------------------------------------
CGRect CGRectIntegralMake(CGFloat x,
                          CGFloat y,
                          CGFloat width,
                          CGFloat height)
//----------------------------------------------------------------------
{
    return CGRectIntegralScaledEx(CGRectMake(x,
                                             y,
                                             width,
                                             height), [[UIScreen mainScreen] scale]);
}

//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                   toSize:(CGSize)size
//----------------------------------------------------------------------
{
    if ( !view || size.height == NAN || size.width == NAN) { return; }
    CGRect frame = view.frame;
    frame.origin = CGPointMake(floorf(frame.origin.x), floorf(frame.origin.y));
    frame.size = CGSizeMake(floorf(size.width), floorf(size.height));
    view.frame = frame;
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                  toWidth:(CGFloat)width
//----------------------------------------------------------------------
{
    if (!view) { return; }
        [self changeFrameOfView:view
                         toSize:CGSizeMake(width, view.frame.size.height)];
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                 toHeight:(CGFloat)height
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self changeFrameOfView:view
                     toSize:
     CGSizeMake(view.frame.size.width, height)];
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                  toWidth:(CGFloat)width
                andHeight:(CGFloat)height
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self changeFrameOfView:view
                     toSize:CGSizeMake(width, height)];
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
                 toOrigin:(CGPoint)origin
//----------------------------------------------------------------------
{
    if (!view) { return; }
    CGRect frame = view.frame;
    frame.origin = CGPointMake(floorf(origin.x), floorf(origin.y));
    view.frame = frame;
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
              toXPosition:(CGFloat)xPos
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self
     changeFrameOfView:view
     toOrigin:CGPointMake(xPos,view.frame.origin.y)];
}


//----------------------------------------------------------------------
+ (void)changeFrameOfView:(UIView *)view
              toYPosition:(CGFloat)yPos
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self
     changeFrameOfView:view
     toOrigin:CGPointMake(view.frame.origin.x,yPos)];
}


//----------------------------------------------------------------------
+ (void)addHeight:(CGFloat)value toView:(UIView *)view
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self changeFrameOfView:view
                   toHeight:view.frame.size.height + value];
}


//----------------------------------------------------------------------
+ (void)addWidth:(CGFloat)value toView:(UIView *)view
//----------------------------------------------------------------------
{
    if (!view) { return; }
    [self changeFrameOfView:view
                   toWidth:view.frame.size.width + value];
}


//----------------------------------------------------------------------
+ (void)addXMargin:(CGFloat)value toView:(UIView *)view
//----------------------------------------------------------------------
{
    if ( value == 0.f ) { return; }
    [self changeFrameOfView:view
                   toXPosition:view.frame.origin.x + value];
}


//----------------------------------------------------------------------
+ (void)addYMargin:(CGFloat)value toView:(UIView *)view
//----------------------------------------------------------------------
{
    if ( value == 0.f ) { return; }
    [self changeFrameOfView:view
                   toYPosition:view.frame.origin.y + value];
}


#pragma mark arranging views

//----------------------------------------------------------------------
+ (void)arrangeView:(UIView *)view
          underView:(UIView *)upperView
         withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    CGFloat yPos =
    upperView.frame.size.height +
    upperView.frame.origin.y +
    margin;
    
    [self changeFrameOfView:view
                        toYPosition:yPos];
}


//----------------------------------------------------------------------
+ (void)arrangeView:(UIView *)view
           overView:(UIView *)upperView
         withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    CGFloat yPos =
    upperView.frame.origin.y -
    (view.frame.size.height +
     margin);
    
    [self changeFrameOfView:view
                        toYPosition:yPos];
}


//----------------------------------------------------------------------
+ (void)arrangeView:(UIView *)view
        rightToView:(UIView *)upperView
         withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    CGFloat xPos =
    upperView.frame.origin.x +
    upperView.frame.size.width +
    margin;
    
    [self changeFrameOfView:view
                        toXPosition:xPos];
}


//----------------------------------------------------------------------
+ (void)arrangeView:(UIView *)view
         leftToView:(UIView *)upperView
         withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    CGFloat xPos =
    upperView.frame.origin.x -
    view.frame.size.width -
    margin;
    
    [self changeFrameOfView:view
                        toXPosition:xPos];
}


//----------------------------------------------------------------------
+ (void)rightAlignView:(UIView *)view
 inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    UIView *superView = view.superview;
    
    [self
     changeFrameOfView:view
     toXPosition:superView.frame.size.width -
     view.frame.size.width - margin];
}




//----------------------------------------------------------------------
+ (void)bottomAlignView:(UIView *)view
  inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    UIView *superView = view.superview;
    
    [self
     changeFrameOfView:view
     toYPosition:superView.frame.size.height -
     view.frame.size.height - margin];
}

//----------------------------------------------------------------------
+ (void)rightBottomCornerAlignView:(UIView *)view
             inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    UIView *superView = view.superview;
    
    [self changeFrameOfView:view toOrigin:CGPointMake((superView.frame.size.width - view.frame.size.width) - margin,
                                                      superView.frame.size.height - view.frame.size.height - margin)];
}

//----------------------------------------------------------------------
+ (void)leftBottomCornerAlignView:(UIView *)view
            inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    UIView *superView = view.superview;
    [self changeFrameOfView:view toOrigin:CGPointMake(margin,
                                                      superView.frame.size.height - view.frame.size.height - margin)];
}

//----------------------------------------------------------------------
+ (void)rightTopCornerAlignView:(UIView *)view
          inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    UIView *superView = view.superview;
    [self changeFrameOfView:view toOrigin:CGPointMake(superView.frame.size.width - view.frame.size.width - margin,
                                                      margin)];
}

//----------------------------------------------------------------------
+ (void)leftTopCornerAlignView:(UIView *)view
         inSuperViewWithMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    [self changeFrameOfView:view toOrigin:CGPointMake(margin,
                                                      margin)];
}

//----------------------------------------------------------------------
+ (void)horizontalCenterViewInSuperView:(UIView *)view
                          addLeftMargin:(CGFloat)leftMargin
//----------------------------------------------------------------------
{
    if ( !view.superview ) {
        return;
    }
    
    CGRect superframe = view.superview.frame;
    CGRect frame = view.frame;
    
    frame.origin.x =
    (superframe.size.width - frame.size.width) / 2.0
    + leftMargin;
    frame = CGRectIntegralScaled(frame);
    
    view.frame = frame;
}


//----------------------------------------------------------------------
+ (void)verticalCenterViewInSuperView:(UIView *)view
                         addTopMargin:(CGFloat)topMargin
//----------------------------------------------------------------------
{
    if ( !view.superview ) {
        return;
    }
    
    CGRect superframe = view.superview.frame;
    CGRect frame = view.frame;
    
    frame.origin.y = (superframe.size.height - frame.size.height) / 2.0 + topMargin;
    frame = CGRectIntegralScaled(frame);
    
    view.frame = frame;
}
//----------------------------------------------------------------------
+ (void)verticalCenterViewInSuperViewUntouched:(UIView *)view
                                  addTopMargin:(CGFloat)topMargin
//----------------------------------------------------------------------
{
    if ( !view.superview ) {
        return;
    }
    
    CGRect superframe = view.superview.frame;
    CGRect frame = view.frame;
    
    frame.origin.y = (superframe.size.height - frame.size.height) / 2.0 + topMargin;
    
    view.frame = frame;
}


//----------------------------------------------------------------------
+ (void)horizontalCenterView:(UIView *)view
              realtiveToView:(UIView *)relatedView
               addLeftMargin:(CGFloat)leftMargin
//----------------------------------------------------------------------
{
    if ( view.superview != relatedView.superview ) { return; }
    
    CGFloat yPos = floorf(view.frame.origin.y);
    view.center = relatedView.center;
    [self changeFrameOfView:view toYPosition:yPos];
    [self addXMargin:leftMargin toView:view];
}


//----------------------------------------------------------------------
+ (void)verticalCenterView:(UIView *)view
            realtiveToView:(UIView *)relatedView
              addTopMargin:(CGFloat)topMargin
//----------------------------------------------------------------------
{
    if ( view.superview != relatedView.superview ) { return; }
    
    CGFloat xPos = floorf(view.frame.origin.x);
    view.center = relatedView.center;
    [self changeFrameOfView:view toXPosition:xPos];
    [self addYMargin:topMargin toView:view];
}


//----------------------------------------------------------------------
+ (void)verticalTopView:(UIView *)view
            realtiveToView:(UIView *)relatedView
              addTopMargin:(CGFloat)topMargin
//----------------------------------------------------------------------
{
    if ( view.superview != relatedView.superview ) { return; }
    
    CGFloat yPos = floorf(relatedView.frame.origin.y);
    [self changeFrameOfView:view toYPosition:yPos];
    [self addYMargin:topMargin toView:view];
}


#pragma mark sizing

//----------------------------------------------------------------------
+ (BOOL)isRetina
//----------------------------------------------------------------------
{
    if ([OFViewHelper displayScaleFactor] == 2.f) {
        return YES;
    }
    
    return NO;
}


//----------------------------------------------------------------------
+ (CGFloat)displayScaleFactor
//----------------------------------------------------------------------
{
    if ([[UIScreen mainScreen]
         respondsToSelector:@selector(scale)]) {
        return [[UIScreen mainScreen] scale];
    } else {
        return 0;
    }
}
//----------------------------------------------------------------------
+ (BOOL)isiPhone4InchScreen
//----------------------------------------------------------------------
{
    if ( [[UIScreen mainScreen] bounds].size.height
        > 480.0 )
    {
        return YES;
    }
    return NO;
}
//----------------------------------------------------------------------
+ (NSString*)imageScaleSuffix
//----------------------------------------------------------------------
{
    switch ((NSInteger)[OFViewHelper displayScaleFactor]) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        case 2:
            return @"@2x";
            break;
        case 3:
            return @"@3x";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark iPhone 5 fixes

//----------------------------------------------------------------------
+ (void)fixPositionOfView:(UIView *)view
   foriPhone4InchAtBottom:(BOOL)bottom
//----------------------------------------------------------------------
{
    if ( !view || ![self isiPhone4InchScreen] ) {
        return;
    }
    CGFloat fixAddition = 568.0 -480.0;
    
    if ( !bottom ) {
        fixAddition /= 2.0;
    }
    
    [self changeFrameOfView:view
                toYPosition:
     view.frame.origin.y+fixAddition];
}


//----------------------------------------------------------------------
+ (void)fixPositionOfManyViews:(NSArray *)views
        foriPhone4InchAtBottom:(BOOL)bottom
//----------------------------------------------------------------------
{
    for (UIView *view in views) {
        if ( ![view isKindOfClass:[UIView class]]) {
            continue;
        }
        [self fixPositionOfView:view
         foriPhone4InchAtBottom:bottom];
    }
}


//----------------------------------------------------------------------
+ (void)stretchView:(UIView *)view
 foriPhone4InchFull:(BOOL)full
//----------------------------------------------------------------------
{
    if ( !view || ![self isiPhone4InchScreen] ) {
        return;
    }
    CGFloat fixAddition = 568.0 - 480.0;
    
    if ( !full ) {
        fixAddition /= 2.0;
    }
    
    [self changeFrameOfView:view
                   toHeight:
     view.frame.size.height+fixAddition];
}


//----------------------------------------------------------------------
+ (void)stretchManyViews:(NSArray *)views
      foriPhone4InchFull:(BOOL)full
//----------------------------------------------------------------------
{
    for (UIView *view in views) {
        if ( ![view isKindOfClass:[UIView class]]) {
            continue;
        }
        [self stretchView:view
       foriPhone4InchFull:full];
    }
}


//----------------------------------------------------------------------
+ (NSString *)imageNameForDevice:(NSString *)orgImgName
//----------------------------------------------------------------------
{
    NSString *extension = [orgImgName pathExtension];
    NSString *retImgName = orgImgName;
    
    // remove extension if any
    if ( extension.length > 0 ) {
        retImgName =
        [orgImgName
         stringByReplacingOccurrencesOfString:
         [NSString stringWithFormat:@".%@", extension]
         withString:@""];
    }
    
    // remove retina extension if any
    retImgName =
    [retImgName
     stringByReplacingOccurrencesOfString:@"@2x"
     withString:@""];
    
    // iphone 4 inch - name-specificatoin
    if ( [self isiPhone4InchScreen] ) {
        retImgName =
        [retImgName stringByAppendingString:@"-568h@2x"];
    }
    
    // adding (removed) extension
    if ( extension.length < 1 ) {
        extension = @"png";
    }
    
    retImgName =
    [retImgName stringByAppendingFormat:
     @".%@", extension];
    
    return retImgName;
}



#pragma mark fitting in

//----------------------------------------------------------------------
+ (void)horizontalFitView:(UIView *)view
              betweenLeft:(UIView *)leftView
                 andRight:(UIView *)rightView
               withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    if ( leftView ) {
        [self arrangeView:view
              rightToView:leftView
               withMargin:margin];
    }else {
        [self changeFrameOfView:view
                    toXPosition:margin];
    }
    
    CGFloat width = view.frame.size.width;
    
    if ( rightView ) {
        width = rightView.frame.origin.x
        - 2*margin - view.frame.origin.x;
    } else if (view.superview ){
        width = view.superview.frame.size.width
        - margin - view.frame.origin.x;
    }
    
    [self changeFrameOfView:view toWidth:width];
}


//----------------------------------------------------------------------
+ (void)verticalFitView:(UIView *)view
             betweenTop:(UIView *)upperView
              andBottom:(UIView *)underView
             withMargin:(CGFloat)margin
//----------------------------------------------------------------------
{
    
    if ( upperView ) {
        [self arrangeView:view
                underView:upperView
               withMargin:margin];
    } else {
        [self changeFrameOfView:view
                    toYPosition:margin];
    }
    
    
    CGFloat height = view.frame.size.height;
    
    if ( underView ) {
        height = underView.frame.origin.y
        - 2*margin - view.frame.origin.y;
    } else if (view.superview ){
        height = view.superview.frame.size.height
        - margin - view.frame.origin.y;
    }
    
    [self changeFrameOfView:view toHeight:height];
}


//----------------------------------------------------------------------
+ (void)verticalFitView:(UIView *)view
             betweenTop:(UIView *)upperView
              andBottom:(UIView *)underView
          withTopMargin:(CGFloat)marginToTop
        andBottomMargin:(CGFloat)marginToBottom
//----------------------------------------------------------------------
{
    
    if ( upperView ) {
        [self arrangeView:view
                underView:upperView
               withMargin:marginToTop];
    } else {
        [self changeFrameOfView:view
                    toYPosition:marginToTop];
    }
    
    
    CGFloat height = view.frame.size.height;
    
    if ( underView ) {
        height = underView.frame.origin.y
        - (marginToTop+marginToBottom) - view.frame.origin.y;
    } else if (view.superview ){
        height = view.superview.frame.size.height
        - marginToBottom - view.frame.origin.y;
    }
    
    [self changeFrameOfView:view toHeight:height];
}


#pragma mark imageview

//----------------------------------------------------------------------
+ (CGRect)imageFrameOfImageInImageView:(UIImageView *)iv
//----------------------------------------------------------------------
{
    CGSize imageSize = iv.image.size;
    CGFloat imageScale =
    fminf(CGRectGetWidth(iv.bounds)/imageSize.width
          , CGRectGetHeight(iv.bounds)/imageSize.height);
    
    CGSize scaledImageSize =
    CGSizeMake(imageSize.width*imageScale
               , imageSize.height*imageScale);
    
    CGRect imageFrame =
    CGRectMake(floorf(0.5f*(CGRectGetWidth(iv.bounds)
                            -scaledImageSize.width))
               , floorf(0.5f*(CGRectGetHeight(iv.bounds)
                              -scaledImageSize.height))
               , scaledImageSize.width
               , scaledImageSize.height);
    
    return imageFrame;
}


//----------------------------------------------------------------------
+ (void)sizeImageviewToImageBounds:(UIImageView *)iv
//----------------------------------------------------------------------
{
    [iv setFrame:CGRectMake((NSInteger)iv.frame.origin.x,
                            (NSInteger)iv.frame.origin.y,
                            iv.image.size.width,
                            iv.image.size.height)];
}

//----------------------------------------------------------------------
+ (void)sizeImageviewToImageBounds:(UIImageView *)iv
                       withPadding:(CGSize)padding
//----------------------------------------------------------------------
{
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    [iv setFrame:CGRectMake(iv.frame.origin.x,
                            iv.frame.origin.y,
                            iv.image.size.width + padding.width,
                            iv.image.size.height + padding.height)];
    [OFViewHelper verticalCenterViewInSuperView:iv addTopMargin:0];
    [OFViewHelper horizontalCenterViewInSuperView:iv addLeftMargin:0];
}


#pragma mark layer

//--------------------------------------------------------------------------------
+ (void)drawShadowOnView:(UIView *)view withRadius:(CGFloat)radius
//--------------------------------------------------------------------------------
{
    if (radius == 0.f ) { return; }
    CALayer * mainLayer = [view layer];
    mainLayer.masksToBounds = NO;
    CGPathRef pathRect = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    mainLayer.shadowColor = [UIColor blackColor].CGColor;
    mainLayer.shadowOffset = CGSizeMake(0.0, 0.0);
    mainLayer.shadowOpacity = 0.8f;
    mainLayer.shadowPath = pathRect;
    mainLayer.shadowRadius = radius;
}


//--------------------------------------------------------------------------------
+ (void)removeShadowFromView:(UIView *)view
//--------------------------------------------------------------------------------
{
    CALayer * mainLayer = [view layer];
    mainLayer.shadowRadius = 0.0f;
}


//--------------------------------------------------------------------------------
+ (void)updateShadowFrameOnView:(UIView *)view
//--------------------------------------------------------------------------------
{
    CALayer * mainLayer = [view layer];
    CGPathRef pathRect = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    mainLayer.shadowPath = pathRect;
}

#pragma mark - Label Helpers
//--------------------------------------------------------------------------------
+ (void)sizeLabelToCorrectValue:(UILabel *)labelToSize
                       forWidth:(BOOL)isWidth
                    withPadding:(NSInteger)padding
//--------------------------------------------------------------------------------
{
    CGFloat insets = 0;
// for people who use TTTAttributedLabel Label, comment this code in
    /*
    if ([labelToSize isKindOfClass:[TTTAttributedLabel class]]) {
        if(isWidth) {
            [OFViewHelper changeFrameOfView:labelToSize
                                    toWidth:[OFViewHelper calculateAttributedLabelWitdhWithHeight:labelToSize.frame.size.height
                                                                                          andText:labelToSize.attributedText] + padding + insets];
        }
        else{
            [OFViewHelper changeFrameOfView:labelToSize
                                   toHeight:[OFViewHelper calculateAttributedLabelHeightWithWidth:labelToSize.frame.size.width
                                                                                          andText:labelToSize.attributedText] + padding + insets];
        }
    }
    else {
     */
        if(isWidth) {
            [OFViewHelper changeFrameOfView:labelToSize
                                    toWidth:[OFViewHelper calculateLabelWitdhWithHeight:labelToSize.frame.size.height
                                                                                andText:labelToSize.text
                                                                           andLabelFont:labelToSize.font] + padding + insets];
        }
        else{
            [OFViewHelper changeFrameOfView:labelToSize
                                   toHeight:[OFViewHelper calculateLabelHeightWithWidth:labelToSize.frame.size.width
                                                                                andText:labelToSize.text
                                                                           andLabelFont:labelToSize.font] + padding + insets];
        }
//    }

}

//--------------------------------------------------------------------------------
+ (void)sizeLabelWithAttributedStringToCorrectValue:(UILabel *)labelToSize
                                           forWidth:(BOOL)isWidth
                                        withPadding:(NSInteger)padding
//--------------------------------------------------------------------------------
{
    if (labelToSize.attributedText.length > 0) {
        if (isWidth) {
            [OFViewHelper changeFrameOfView:labelToSize
                                    toWidth:[OFViewHelper calculateAttributedLabelWitdhWithHeight:labelToSize.frame.size.height
                                                                                          andText:labelToSize.attributedText] + padding];
        }
        else{
            [OFViewHelper changeFrameOfView:labelToSize
                                    toWidth:[OFViewHelper calculateAttributedLabelHeightWithWidth:labelToSize.frame.size.width
                                                                                          andText:labelToSize.attributedText] + padding];
        }
    }
}

//--------------------------------------------------------------------------------
+ (CGFloat)calculateLabelHeightWithWidth:(CGFloat)availableWidth
                                 andText:(NSString *)text
                            andLabelFont:(UIFont *)font
//--------------------------------------------------------------------------------
{
    if (text && font && availableWidth > 0)
    {
        NSDictionary *headerAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,font, NSFontAttributeName,nil];
        
        return ceil([text boundingRectWithSize:CGSizeMake(availableWidth, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:headerAttributes
                                       context:nil].size.height);
        
    }
    return 0;
}

//--------------------------------------------------------------------------------
+ (CGFloat)calculateAttributedLabelHeightWithWidth:(CGFloat)availableWidth
                                           andText:(NSAttributedString *)text
//--------------------------------------------------------------------------------
{
    if (text)
    {
        return ceil([text boundingRectWithSize:CGSizeMake(availableWidth, CGFLOAT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       context:nil].size.height);
        
    }
    return 0;
}

//--------------------------------------------------------------------------------
+ (CGFloat)calculateLabelWitdhWithHeight:(CGFloat)availableHeight
                                 andText:(NSString *)text
                            andLabelFont:(UIFont *)font
//--------------------------------------------------------------------------------
{
    if (text && font && availableHeight > 0)
    {
        NSDictionary *headerAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,font, NSFontAttributeName,nil];
        
        return ceil([text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, availableHeight)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:headerAttributes
                                       context:nil].size.width);
        
    }
    return 0;
}

//--------------------------------------------------------------------------------
+ (CGFloat)calculateAttributedLabelWitdhWithHeight:(CGFloat)availableHeight
                                           andText:(NSAttributedString *)text
//--------------------------------------------------------------------------------
{
    if (text)
    {
        return ceil([text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, availableHeight)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            context:nil].size.width);
        
    }
    return 0;
}

#pragma mark - Button Helpers

//--------------------------------------------------------------------------------
+ (void)sizeButtonToCorrectValue:(UIButton *)buttonToSize
                        forWidth:(BOOL)isWidth
//--------------------------------------------------------------------------------
{
    if (isWidth) {
        [OFViewHelper changeFrameOfView:buttonToSize
                                toWidth:[OFViewHelper calculateLabelWitdhWithHeight:buttonToSize.frame.size.height
                                                                            andText:buttonToSize.titleLabel.text
                                                                       andLabelFont:buttonToSize.titleLabel.font]];
    }
    else{
        [OFViewHelper changeFrameOfView:buttonToSize
                               toHeight:[OFViewHelper calculateLabelHeightWithWidth:buttonToSize.frame.size.width
                                                                            andText:buttonToSize.titleLabel.text
                                                                       andLabelFont:buttonToSize.titleLabel.font]];
    }
    
}


#pragma mark - Font Helpers

//----------------------------------------------------------------------------------------------
+ (CGFloat)compareFont:(UIFont*)font1
                  with:(UIFont*)font2
//----------------------------------------------------------------------------------------------
{
    NSString *stringToCompare = @"1234567890qwertzuiopasdfghjklyxcvbnmQWERTZUIOPASDFGHJKLYXCVBNM";
    
    CGSize sizeOfFont1 = [stringToCompare sizeWithAttributes:
                          @{NSFontAttributeName: font1}];
    
    CGSize sizeOfFont2 = [stringToCompare sizeWithAttributes:
                          @{NSFontAttributeName: font2}];
    
    return ceilf(( 100 * sizeOfFont2.width ) / sizeOfFont1.width);
}

+ (CGFloat)scaleToMaxHeightAndSizeForScreen:(CGSize)sizeOfObject
{
    return ((sizeOfObject.height * [UIScreen mainScreen].bounds.size.width) / sizeOfObject.width);
}

+ (CGFloat)calculateNeededHeightForUnscaledImagesForWidth:(CGFloat)width andImage:(UIImage *)image
{
    CGSize sizeToCalc = CGSizeMake(image.size.width, image.size.height);
    long neededHeight = ceilf((sizeToCalc.height * width) / sizeToCalc.width);
    return neededHeight;
}

//----------------------------------------------------------------------------------------------
+ (CGFloat)calculateNeededHeightForUnscaledImagesForWidth:(CGFloat)width
                                       andImageDimensions:(CGSize)size
//----------------------------------------------------------------------------------------------
{
    CGSize sizeToCalc = CGSizeMake(size.width, size.height);
    long neededHeight = ceilf((sizeToCalc.height * width) / sizeToCalc.width);
    return neededHeight;
}

//----------------------------------------------------------------------------------------------
+ (CGRect)adaptFrameSizeOnDeviceSize:(CGRect)frameToFit
//----------------------------------------------------------------------------------------------
{
    CGFloat neededHeight = floorf((frameToFit.size.height * [UIScreen mainScreen].bounds.size.width) / frameToFit.size.width);
    return CGRectMake(frameToFit.origin.x, frameToFit.origin.y, [UIScreen mainScreen].bounds.size.width, neededHeight);
}

//----------------------------------------------------------------------------------------------
+ (CGRect)flatFrame:(CGRect)frame option:(FrameFlatMode)mode
//----------------------------------------------------------------------------------------------
{
    
    CGRect newFrame;
    switch (mode) {
        case kPureFlat:
            newFrame = CGRectIntegral(frame);
            break;
        case kDownFlat:
            newFrame = CGRectIntegralScaled(frame);
            break;
        case kUpFlat:
            newFrame = CGRectMake((int)frame.origin.x + 0.9,
                                  (int)frame.origin.y + 0.9,
                                  (int)frame.size.width + 0.9,
                                  (int)frame.size.height+ 0.9);
            break;
        case kAvoidUnderNull:
            newFrame = CGRectStandardize(frame);
            break;
    }

    return newFrame;
}

//----------------------------------------------------------------------------------------------
+ (void)sizeScrollview:(UIScrollView*)scrollView
         toThisElement:(UIView*)view
               padding:(NSInteger)pading
//----------------------------------------------------------------------------------------------
{
    [scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                          (view.frame.size.height + view.frame.origin.y + pading))];
}

//----------------------------------------------------------------------------------------------
+ (BOOL)doesString:(NSString*)string
      fitWithWidth:(NSInteger)width
        baseOnFont:(UIFont*)font
//----------------------------------------------------------------------------------------------
{
    NSDictionary *headerAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,font, NSFontAttributeName,nil];

    CGFloat calcWidth = ceil([string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 30)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:headerAttributes
                                                  context:nil].size.width);
    return (calcWidth < width);
}



@end
