//
//  SPDDynamicDropMenuViewController.m
//  JunoFinal
//
//  Created by Steve Park on 2013. 6. 22..
//  Copyright (c) 2013년 Steve Park. All rights reserved.
//

#import "SPDDynamicDropMenuViewController.h"

@interface SPDDynamicDropMenuViewController () <UIDynamicAnimatorDelegate, UICollisionBehaviorDelegate>
{
    UIGravityBehavior* gravityBeahvior;
    UICollisionBehavior* collisionBehavior;
}
@property (nonatomic) UIDynamicAnimator* animator;

@end

@implementation SPDDynamicDropMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // 이미지를 원형으로...
    self.menuImage.layer.borderWidth = 2;
    self.menuImage.layer.borderColor = [UIColor blackColor].CGColor;
    self.menuImage.layer.cornerRadius = CGRectGetHeight(self.menuImage.bounds) / 2;
    self.menuImage.clipsToBounds = YES;
    
    self.menuImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.view addSubview:self.menuImage];
    self.menuImage.center = CGPointMake(self.view.frame.size.width/2, - self.menuImage.frame.size.height*2);
}


-(void)resetPosition {
    self.menuImage.center = CGPointMake(self.view.frame.size.width/2, 0);
    [self viewDidAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    
    // 일단 뷰가 화면에 나타난 후에 적용해야 확실하게 볼 수 있음. 애니메이터는 참조 뷰를 설정하는게 중요함.
    // 설정된 뷰에서 애니메이터는 동작하며 설정된 뷰의 좌표계에서 동작함...
    UIDynamicAnimator* animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // 다이나믹 아이템에 중력 속성을 추가해줌.
    gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[self.menuImage]];
    gravityBeahvior.yComponent = 0.5;
    
    
    // 충돌 속성
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.menuImage]];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    // 이렇게 하면 가운데 라인이 생기며 충돌 객체로 동작함...
    [collisionBehavior addBoundaryWithIdentifier:@"centerLine" fromPoint:CGPointMake(0, self.view.frame.size.height/2) toPoint:CGPointMake(self.view.frame.size.width, self.view.frame.size.height/2)];
    

    // 애니메이터에 중력속성을 추가.
    [animator addBehavior:gravityBeahvior];
    
    // 충돌속성을 추가하고 대리자를 명시함...
    [animator addBehavior:collisionBehavior];
    collisionBehavior.collisionDelegate = self;
    
    self.animator = animator;

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 충돌 대리 함수...충돌 시작...
-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    // Lighten the background color when the view is in contact with a boundary.
    // 충돌이 시작되면..
    
    //[(UIView*)item setBackgroundColor:[UIColor randomNaviCrayonColor]];
}

// 충돌 대리 함수...충돌 끝...
-(void)collisionBehavior:(UICollisionBehavior *)behavior endedContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier
{
    // Restore the default color when ending a contcact.
    //[(UIView*)item setBackgroundColor:[UIColor randomNaviCrayonColor]];
}



// 뷰 콘트롤러가 애니메이터의 대리자 역활...
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    
}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    
}


@end
