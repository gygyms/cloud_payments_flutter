package xdev.team.cloudpaymentsflutter

import android.util.Log
import androidx.annotation.NonNull
import io.flutter.app.FlutterFragmentActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import ru.cloudpayments.sdk.cp_card.CPCard
import ru.cloudpayments.sdk.three_ds.ThreeDSDialogListener
import ru.cloudpayments.sdk.three_ds.ThreeDsDialogFragment

/** CloudpaymentsflutterPlugin */
class CloudpaymentsflutterPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity:PluginRegistry.Registrar

  constructor(activity: PluginRegistry.Registrar) {
    this.activity = activity
  }


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "cloudpaymentsflutter")
    channel.setMethodCallHandler(this)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: PluginRegistry.Registrar) {
      val channel = MethodChannel(registrar.messenger(), "cloudpaymentsflutter")
      channel.setMethodCallHandler(CloudpaymentsflutterPlugin(registrar))
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      val cardNumber: String? = call.argument<String>("card_number")
      val isValid = CPCard.isValidNumber(cardNumber)
      val cardDate = call.argument<String>("card_date")
      val cardCVV = call.argument<String>("card_cvv")
    //  var paymentParameters = PaymentParameters(call.arguments as HashMap<String, String>)
      var card = CPCard(cardNumber, cardDate, cardCVV)
      var cryptogram = card.cardCryptogram("pk_4188676afe1f5e9fb8160c3f7377a")
      result.success("${cryptogram}")
    } else {
      if(call.method == "show_3ds"){
        Log.d("3ds","called");
        show3ds("yandex.ru","1","1")
      }
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun show3ds(url:String,transactionId:String,paReq:String){
    Log.d("3ds","called method");
    ((activity).activity() as FlutterFragmentActivity).supportFragmentManager?.let {
      Log.d("3ds","supportFragmentManager exists");
      ThreeDsDialogFragment.newInstance(url,
              transactionId,
              paReq)
              .show(it, "3DS")
    }
  }

  override fun onDetachedFromActivity() {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    Log.d("platform",binding.activity.toString())
  //  activity = binding.activity as FlutterFragmentActivity
    Log.d("platform",activity.toString())
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("not implemented") //To change body of created functions use File | Settings | File Templates.
  }

}
