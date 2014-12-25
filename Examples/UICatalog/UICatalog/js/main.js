var MainViewController = JSB.require('mainViewController');

var bounds = UIScreen.mainScreen().bounds;
//var window = UIWindow.alloc().initWithFrame(bounds);
var window = create_withFrame('UIWindow',bounds);
window.backgroundColor = UIColor.whiteColor();

var navigationController = UINavigationController.new();

var mainViewController = MainViewController.new();
navigationController.viewControllers = [mainViewController];

window.rootViewController = navigationController;

window.makeKeyAndVisible();
