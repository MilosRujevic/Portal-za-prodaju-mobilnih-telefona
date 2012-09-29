package main.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import com.blundell.tut.LoaderImageView;
import java.util.ArrayList;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import soapobjects.SoapComment;
import soapobjects.SoapDevice;

/**
 *
 * @author Aleksandar Abu-Samra
 */
public class DeviceActivity extends Activity {
	private int deviceId;

	/**
	 * Called when the activity is first created.
	 */
	@Override
	public void onCreate(Bundle icicle) {
		super.onCreate(icicle);
		setContentView(R.layout.device);
		
		Intent intent = getIntent();
		String message = intent.getStringExtra(MainActivity.DEVICE_ID);
		
		deviceId = Integer.parseInt(message);
		
		// SOAP
		String NAMESPACE = "http://portmob.com/";
        String METHOD_NAME = "GetDevice";
        String SOAP_ACTION = NAMESPACE + METHOD_NAME;
        String URL = Consts.SERVER + "Services/DeviceDetailsService.asmx";
		
		SoapObject so = new SoapObject(NAMESPACE, METHOD_NAME);
		so.addProperty("id", deviceId);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER12);
		envelope.dotNet = true;
		envelope.setOutputSoapObject(so);
		
		HttpTransportSE androidHttpTransport = new HttpTransportSE(URL);
		
		SoapDevice device = new SoapDevice();
		
		try {
			androidHttpTransport.call(SOAP_ACTION, envelope);
			SoapObject response = (SoapObject)envelope.getResponse();
			
			device.name = response.getProperty(1).toString();
			device.company = response.getProperty(2).toString();
			device.specShape = response.getProperty(3).toString();
			device.specOs = response.getProperty(4).toString();
			device.specConnectivity = response.getProperty(5).toString();
			device.specDisplay = response.getProperty(6).toString();
			device.specInterface = response.getProperty(7).toString();
			device.specCamera = response.getProperty(8).toString();
			device.specMemory = response.getProperty(9).toString();
			device.specBattery = response.getProperty(10).toString();
			device.available = Integer.parseInt(response.getProperty(11).toString());
			device.price = Double.parseDouble(response.getProperty(12).toString());
			device.picture = response.getProperty(13).toString();
		}
		catch(Exception e) {
		}

		// update layout
		
		// device info
		LoaderImageView image = (LoaderImageView) findViewById(R.id.device_image);
		image.setImageDrawable(device.picture);
		
		TextView tv;
		
		tv = (TextView) findViewById(R.id.DeviceName);
		tv.setText(device.name);
		
		tv = (TextView) findViewById(R.id.Company);
		tv.setText(device.company);
		
		tv = (TextView) findViewById(R.id.SpecShape);
		tv.setText(device.specShape);
		
		tv = (TextView) findViewById(R.id.SpecOs);
		tv.setText(device.specOs);
		
		tv = (TextView) findViewById(R.id.SpecConnectivity);
		tv.setText(device.specConnectivity);
		
		tv = (TextView) findViewById(R.id.SpecDisplay);
		tv.setText(device.specDisplay);
		
		tv = (TextView) findViewById(R.id.SpecInterface);
		tv.setText(device.specInterface);
		
		tv = (TextView) findViewById(R.id.SpecCamera);
		tv.setText(device.specCamera);
		
		tv = (TextView) findViewById(R.id.SpecMemory);
		tv.setText(device.specMemory);
		
		tv = (TextView) findViewById(R.id.SpecBattery);
		tv.setText(device.specBattery);
		
		tv = (TextView) findViewById(R.id.Available);
		tv.setText(Integer.toString(device.available));
		
		tv = (TextView) findViewById(R.id.Price);
		tv.setText(Double.toString(device.price));
		
		drawCommentsTable();
	}
	
	/**
	 * Display existing device comments
	 */
	public void drawCommentsTable() {
		// get comments
				
		// SOAP
		String NAMESPACE = "http://portmob.com/";
		String METHOD_NAME = "GetComments";
        String SOAP_ACTION = NAMESPACE + METHOD_NAME;
		String URL = Consts.SERVER + "Services/CommentService.asmx";
		
		SoapObject so = new SoapObject(NAMESPACE, METHOD_NAME);
		so.addProperty("deviceId", deviceId);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER12);
        envelope.dotNet = true;
        envelope.setOutputSoapObject(so);
		
		HttpTransportSE androidHttpTransport = new HttpTransportSE(URL);
		
		ArrayList<SoapComment> comments = new ArrayList<SoapComment>();
		
		try {
			androidHttpTransport.call(SOAP_ACTION, envelope);
			SoapObject response = (SoapObject)envelope.getResponse();
			
			int totalCount = response.getPropertyCount();
			
			for (int i = 0; i < totalCount; i++) {
				SoapObject sod = (SoapObject)response.getProperty(i);
				//if (sod == null) break;
						
				SoapComment comment = new SoapComment();
				comment.pros = sod.getProperty(0).toString();
				comment.cons = sod.getProperty(1).toString();
				comment.nickname = sod.getProperty(2).toString();
				
				comments.add(comment);
			}			
		}
		catch(Exception e) {
			String test = e.toString();
		}
		
		
		// draw comments
		TableLayout commentsTable = (TableLayout) findViewById(R.id.commentsTable);
		
		for (SoapComment comment : comments) {
			TableRow tr = new TableRow(this);
			
			TextView nickname = new TextView(this);
			nickname.setText(comment.nickname);
			
			TextView pros = new TextView(this);
			pros.setText(comment.pros);
			
			TextView cons = new TextView(this);
			cons.setText(comment.cons);
						
			tr.addView(nickname);
			tr.addView(pros);
			tr.addView(cons);
			
			commentsTable.addView(tr);
		}
		
//		setContentView(commentsTable);
	}
	
	public void postComment(View view) {
		/*
		Intent intent = getIntent();
		String message = intent.getStringExtra(MainActivity.DEVICE_ID);
		
		int deviceId = Integer.parseInt(message);
		*/
		
		EditText editText = (EditText) findViewById(R.id.nickname);
		String nickname = editText.getText().toString();
		
		editText = (EditText) findViewById(R.id.pros);
		String pros = editText.getText().toString();
		
		editText = (EditText) findViewById(R.id.cons);
		String cons = editText.getText().toString();
		
		
		// SOAP
		String NAMESPACE = "http://portmob.com/";
        String METHOD_NAME = "PostComment";
        String SOAP_ACTION = NAMESPACE + METHOD_NAME;
        String URL = Consts.SERVER + "Services/CommentService.asmx";
	
		SoapObject so = new SoapObject(NAMESPACE, METHOD_NAME);
		so.addProperty("deviceId", deviceId);
		so.addProperty("nickname", nickname);
		so.addProperty("pros", pros);
		so.addProperty("cons", cons);
		
		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
        envelope.dotNet = true;
        envelope.setOutputSoapObject(so);
		
		HttpTransportSE androidHttpTransport = new HttpTransportSE(URL);
		
		try {
			androidHttpTransport.call(SOAP_ACTION, envelope);
			SoapObject response = (SoapObject)envelope.getResponse();
		}
		catch(Exception e) {
		}
		
		startActivity(getIntent()); finish();
	}
}
