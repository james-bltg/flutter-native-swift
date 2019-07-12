import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
	
	
  var navigationController: UINavigationController?
	
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
	
	let controller = FlutterViewController()
	
	self.navigationController = UINavigationController.init(rootViewController: controller)
	window = UIWindow(frame: UIScreen.main.bounds)
	window?.rootViewController = self.navigationController
	window?.makeKeyAndVisible()
	

	
	let testChannel = FlutterMethodChannel(name: "samples.flutter.dev/goToNativePage",
											  binaryMessenger: controller)
	testChannel.setMethodCallHandler({
		[weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
		
		let arguments = call.arguments as! NSDictionary
		
		guard call.method == "goToNativePage" else {
			result(FlutterMethodNotImplemented)
			return
		}
		
		self?.goToNativePage(result: result, title: arguments["test"] as! String)
	})
	
	
	
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
	
	
	private func goToNativePage(result: FlutterResult,title: String) {
		print("跳转")
		let vc: UIViewController = NativeViewController()
		vc.navigationItem.title = title
		self.navigationController?.pushViewController(vc, animated: true)
	}
}
