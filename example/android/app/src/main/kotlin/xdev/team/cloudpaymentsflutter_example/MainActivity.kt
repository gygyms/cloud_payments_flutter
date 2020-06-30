package xdev.team.cloudpaymentsflutter_example

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import com.google.android.gms.wallet.AutoResolveHelper
import com.google.android.gms.wallet.PaymentData
import io.flutter.app.FlutterFragmentActivity
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant
import xdev.team.cloudpaymentsflutter.CloudpaymentsflutterPlugin


class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        when (requestCode) {
            CloudpaymentsflutterPlugin.REQUEST_GOOGLE_PLAY_CODE -> {
                when (resultCode) {
                    Activity.RESULT_OK -> {
                        data?.let {
                            val paymentData = PaymentData.getFromIntent(data);
                            val tokenGP = paymentData?.getPaymentMethodToken()?.getToken()
                        }
                    }
                    Activity.RESULT_CANCELED -> {
                    }
                    AutoResolveHelper.RESULT_ERROR -> {
                        AutoResolveHelper.getStatusFromIntent(data)?.statusCode
                    }
                }
            }
        }
    }
}
