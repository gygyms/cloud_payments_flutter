package xdev.team.cloudpaymentsflutter_example

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.app.FlutterFragmentActivity
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant
import ru.cloudpayments.sdk.three_ds.ThreeDSDialogListener


class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
       // when (requestCode) {
            Log.d("gpay",requestCode.toString())
           /* LOAD_PAYMENT_DATA_REQUEST_CODE -> {
                when (resultCode) {
                    Activity.RESULT_OK -> {
                        data?.let {
                            onPaymentSuccess(PaymentData.getFromIntent(data))
                        }
                    }
                    Activity.RESULT_CANCELED -> {
                    }
                    AutoResolveHelper.RESULT_ERROR -> {
                        onError(AutoResolveHelper.getStatusFromIntent(data)?.statusCode)
                    }
                }
                mGooglePayButton.isClickable = true
            }*/
      //  }
    }
}
