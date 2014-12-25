var ButtonsViewController = JSB.require('buttonsViewController');
var ControlsViewController = JSB.require('controlsViewController');
var TwitterViewController = JSB.require('twitterViewController');
var CollectionViewController = JSB.require('collectionViewController');
var WebViewController = JSB.require('webViewController');
var MapViewController = JSB.require('mapViewController');
var GestureViewController = JSB.require('gestureViewController');
var GradientViewController = JSB.require('gradientViewController');

var SpritesViewController = JSB.require('spritesViewController');

var MainViewController = JSB.defineClass('MainViewController : UITableViewController', {
  viewDidLoad: function() {
    self.navigationItem.title = 'UICatalog';
    var collectionVC = create_collectionVC();

    self.menuList = [{
      title: 'Buttons',
      explanation: 'Various uses of UIButton',
//      viewController: ButtonsViewController.alloc().initWithStyle(1)
//     viewController: create_withStyle('ButtonsViewController',1)
     viewController: ButtonsViewController.new()

    },
    {
      title: 'Controls',
      explanation: 'Various uses of UIControl',
//      viewController: ControlsViewController.alloc().initWithStyle(1)
//     viewController: create_withStyle('ControlsViewController',1)
     viewController: ControlsViewController.new()
    },
    {
      title: 'Table View',
      explanation: 'Use of UITableView',
      viewController: TwitterViewController.new()
    },
    {
      title: 'Collection View',
      explanation: 'Use of UICollectionView',
//      viewController: CollectionViewController.alloc().initWithCollectionViewLayout(UICollectionViewFlowLayout.new())
      viewController: collectionVC
    },
    {
      title: 'Web',
      explanation: 'Use of UIWebView',
//      viewController: WebViewController.alloc().init()
      viewController: WebViewController.new()
    },
    {
      title: 'Map',
      explanation: 'Use of MKMapView',
      viewController: MapViewController.new()
    },
    {
      title: 'Gesture',
      explanation: 'Use of UIGestureRecognizer',
      viewController: GestureViewController.new()
    },
    {
      title: 'Gradient Layer',
      explanation: 'Use of CAGradientLayer',
      viewController: GradientViewController.new()
    },
    {
      title: 'SpriteKit',
      explanation: 'Use of SpriteKit',
      viewController: SpritesViewController.new()
    }]
  },
  tableViewNumberOfRowsInSection: function(tableView, section) {
    return self.menuList.length;
  },
  tableViewCellForRowAtIndexPath: function(tableView, indexPath) {
//    var cell = UITableViewCell.alloc().initWithStyleReuseIdentifier(3, 'Cell');
    var cell = create_withStyleReuseIdentifier('UITableViewCell',3, 'Cell');

    cell.accessoryType = 1;
    cell.textLabel.text = self.menuList[indexPath.row]['title'];
    cell.detailTextLabel.text = self.menuList[indexPath.row]['explanation'];

    return cell;
  },
  tableViewDidSelectRowAtIndexPath: function(tableView, indexPath) {
    var targetViewController = self.menuList[indexPath.row]['viewController'];
    self.navigationController.pushViewControllerAnimated(targetViewController, true);
  }
});

JSB.exports = MainViewController;
