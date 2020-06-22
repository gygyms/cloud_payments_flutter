package xdev.team.cloudpaymentsflutter_example

import android.os.Bundle
import io.flutter.app.FlutterFragmentActivity
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant
import ru.cloudpayments.sdk.three_ds.ThreeDSDialogListener


class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)
    }
}
