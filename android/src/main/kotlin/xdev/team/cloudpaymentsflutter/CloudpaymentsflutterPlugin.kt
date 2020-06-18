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
import ru.cloudpayments.sdk.three_ds.ThreeDsDialogFragment

/** CloudpaymentsflutterPlugin */
class CloudpaymentsflutterPlugin: FlutterPlugin, MethodCallHandler,ActivityAware {
  private lateinit var channel : MethodChannel
  private var activity:PluginRegistry.Registrar

  constructor(activity: PluginRegistry.Registrar) {
    this.activity = activity
  }


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.flutterEngine.dartExecutor, "cloudpaymentsflutter")
    channel.setMethodCallHandler(this)
  }


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
      val publicId = call.argument<String>("public_id")
      var card = CPCard(cardNumber, cardDate, cardCVV)
      var cryptogram = card.cardCryptogram(publicId)
      result.success("${cryptogram}")
    } else {
      if(call.method == "show_3ds"){
        val url: String? = call.argument<String>("url")
        val paReq = call.argument<String>("paReq")
        val transactionId = call.argument<String>("transactionId")
        url?.let { transactionId?.let { it1 -> paReq?.let { it2 -> show3ds(it, it1, it2) } } }
      }
      else {
        result.notImplemented()
      }
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
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }


}
