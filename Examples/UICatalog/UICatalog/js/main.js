//var MainViewController = JSB.require('mainViewController');
var ButtonsViewController = JSB.require('buttonsViewController');

var bounds = UIScreen.mainScreen().bounds;

//var window = UIWindow.alloc().initWithFrame(bounds);
var window = create_withFrame('UIWindow',bounds);

//window.backgroundColor = UIColor.whiteColor();
window.backgroundColor = UIColor.redColor();

var navigationController = UINavigationController.new();

//var mainViewController = MainViewController.new();
var mainViewController = ButtonsViewController.new();
navigationController.viewControllers = [mainViewController];

window.rootViewController = navigationController;

window.makeKeyAndVisible();
