package xdev.team.cloudpaymentsflutter

import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import com.google.android.gms.wallet.*
import io.flutter.app.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import ru.cloudpayments.sdk.cp_card.CPCard
import ru.cloudpayments.sdk.three_ds.ThreeDsDialogFragment
import java.util.*

/** CloudpaymentsflutterPlugin */
class CloudpaymentsflutterPlugin: FlutterPlugin, MethodCallHandler,ActivityAware,ru.cloudpayments.sdk.three_ds.ThreeDSDialogListener {
  private lateinit var channel : MethodChannel
  private var activity:PluginRegistry.Registrar
  private lateinit var mPaymentsClient: PaymentsClient


  constructor(activity: PluginRegistry.Registrar) {
    this.activity = activity
    mPaymentsClient = createPaymentsClient(this.activity.activity())
  }

  fun createPaymentsClient(activity: Activity): PaymentsClient {
    val walletOptions = Wallet.WalletOptions.Builder()
            .setEnvironment(WalletConstants.ENVIRONMENT_TEST)
            .build()
    return Wallet.getPaymentsClient(activity, walletOptions)
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
        if(call.method == "google_pay"){
          print("google pay")
          val publicId = call.argument<String>("public_id")
          runGooglePay(publicId.toString())
        }
        else {
          result.notImplemented()
        }
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
  private val SUPPORTED_NETWORKS = Arrays.asList(
          WalletConstants.CARD_NETWORK_VISA,
          WalletConstants.CARD_NETWORK_MASTERCARD
  )
  private val SUPPORTED_METHODS = Arrays.asList(
          WalletConstants.PAYMENT_METHOD_CARD,
          WalletConstants.PAYMENT_METHOD_TOKENIZED_CARD
  )

  fun runGooglePay(publicId:String){
    val params = PaymentMethodTokenizationParameters.newBuilder()
            .setPaymentMethodTokenizationType(
                    WalletConstants.PAYMENT_METHOD_TOKENIZATION_TYPE_PAYMENT_GATEWAY)
            .addParameter("gateway", "cloudpayments")
            .addParameter("gatewayMerchantId", publicId)
            .build()
    val transactionInfo = TransactionInfo.newBuilder()
            .setTotalPriceStatus(WalletConstants.TOTAL_PRICE_STATUS_FINAL)
            .setTotalPrice("1")
            .setCurrencyCode("USD")
            .build()
    val paymentData = PaymentDataRequest.newBuilder()
            .setPhoneNumberRequired(false)
            .setEmailRequired(true)
            .setShippingAddressRequired(true)
            .setShippingAddressRequirements(
                    ShippingAddressRequirements.newBuilder()
                            //.addAllowedCountryCodes(SHIPPING_SUPPORTED_COUNTRIES)
                            .build()
            )
            .setTransactionInfo(transactionInfo)
            .addAllowedPaymentMethods(SUPPORTED_METHODS)
            .setCardRequirements(
                    CardRequirements.newBuilder()
                            .addAllowedCardNetworks(SUPPORTED_NETWORKS)
                            .setAllowPrepaidCards(true)
                            .setBillingAddressFormat(WalletConstants.BILLING_ADDRESS_FORMAT_FULL)
                            .build()
            )
            .setPaymentMethodTokenizationParameters(params)
            .setUiRequired(true)
            .build()
    val futurePaymentData = mPaymentsClient.loadPaymentData(paymentData)
    AutoResolveHelper.resolveTask(futurePaymentData, activity.activity(), 1)
     // val tokenGP = paymentData.getPaymentMethodToken().getToken()
  }

  /*override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
    when (requestCode) {
      LOAD_PAYMENT_DATA_REQUEST_CODE -> {
        when (resultCode) {
          Activity.RESULT_OK -> {
            data?.let {
             // onPaymentSuccess(PaymentData.getFromIntent(data))
            }
          }
          Activity.RESULT_CANCELED -> {
          }
          AutoResolveHelper.RESULT_ERROR -> {
          //  onError(AutoResolveHelper.getStatusFromIntent(data)?.statusCode)
          }
        }
       // mGooglePayButton.isClickable = true
      }
    }
  }*/

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

  override fun onAuthorizationCompleted(md: String?, paRes: String?) {
    Log.d("3ds","onAuthorizationCompleted")
  }

  override fun onAuthorizationFailed(html: String?) {
    Log.d("3ds","onAuthorizationFailed")
  }


}
