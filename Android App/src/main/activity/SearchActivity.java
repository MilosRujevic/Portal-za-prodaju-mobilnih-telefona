package main.activity;

import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import java.util.ArrayList;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import soapobjects.SoapDevice;

/**
 *
 * @author Aleksandar Abu-Samra
 */
public class SearchActivity extends ListActivity {
	private ArrayList<SoapDevice> listDevices;

	private String searchCompany;
	private String searchDevice;
	private String searchOS;
	private String searchPrice;
	private String searchMinmax;
	private int searchStart;
	private int searchSize;


	/**
	 *
	 * @param savedInstanceState
	 */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		// get search parameters
		Intent intent = getIntent();
		searchCompany = intent.getStringExtra(MainActivity.SEARCH_COMPANY);
		searchDevice = intent.getStringExtra(MainActivity.SEARCH_DEVICE);
		searchOS = intent.getStringExtra(MainActivity.SEARCH_OS);
		searchPrice = intent.getStringExtra(MainActivity.SEARCH_PRICE);
		searchMinmax = intent.getStringExtra(MainActivity.SEARCH_MINMAX);
		searchStart = intent.getIntExtra(MainActivity.SEARCH_START, 0);
		searchSize = intent.getIntExtra(MainActivity.SEARCH_SIZE, 5);

		// update list with latest devices
		listDevices = getSearchResults();

		// test next search
		searchStart += searchSize;
		if (!getSearchResults().isEmpty()) {
			SoapDevice nextDevice = new SoapDevice();
			nextDevice.name = "Next >>";

			listDevices.add(nextDevice);
		}
		searchStart -= searchSize; // back to current

		ArrayAdapter<SoapDevice> adapter = new ArrayAdapter<SoapDevice>
				(this, android.R.layout.simple_list_item_1, listDevices);

		setListAdapter(adapter);
	}

	public ArrayList<SoapDevice> getSearchResults() {
		// SOAP
		String NAMESPACE = "http://portmob.com/";
        String METHOD_NAME = "Search";
        String SOAP_ACTION = NAMESPACE + METHOD_NAME;
        String URL = Consts.SERVER + "Services/SearchService.asmx";

		SoapObject so = new SoapObject(NAMESPACE, METHOD_NAME);
		so.addProperty("company", searchCompany);
		so.addProperty("model", searchDevice);
		so.addProperty("os", searchOS);
		so.addProperty("price", searchPrice);
		so.addProperty("minmax", searchMinmax);
		so.addProperty("startItem", searchStart);
		so.addProperty("numOfItems", searchSize);

		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER12);
		envelope.dotNet = true;
		envelope.setOutputSoapObject(so);

		HttpTransportSE androidHttpTransport = new HttpTransportSE(URL);

		ArrayList<SoapDevice> devices = new ArrayList<SoapDevice>();

		try {
			androidHttpTransport.call(SOAP_ACTION, envelope);
			SoapObject response = (SoapObject)envelope.getResponse();

			int totalCount = response.getPropertyCount();

			for (int i = 0; i < totalCount; i++) {
				SoapObject sod = (SoapObject)response.getProperty(i);
				//if (sod == null) break;

				SoapDevice device = new SoapDevice();
				String tmp = sod.getProperty(0).toString();
				device.id = Integer.parseInt(tmp);
				device.name = sod.getProperty(1).toString();

				devices.add(device);
			}

		}
		catch(Exception e) {
		}

		return devices;
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {
		String item = getListAdapter().getItem(position).toString();

		// search next list
		if (item.equals("Next >>")) {
			Intent intent = getNextSearchIntent();

			// open next search activity
			startActivity(intent);
		}
		else {
			// find device id
			int deviceId = -1;
			for (SoapDevice device: listDevices) {
				if (device.name.equals(item)) {
					deviceId = device.id;
					break;
				}
			}

			// open DeviceActiviy
			Intent intent = new Intent(this, DeviceActivity.class);
			intent.putExtra(MainActivity.DEVICE_ID, Integer.toString(deviceId));
			startActivity(intent);
		}
	}

	private Intent getNextSearchIntent() {
		Intent intent = new Intent(this, SearchActivity.class);
		intent.putExtra(MainActivity.SEARCH_COMPANY, searchCompany);
		intent.putExtra(MainActivity.SEARCH_DEVICE, searchDevice);
		intent.putExtra(MainActivity.SEARCH_OS, searchOS);
		intent.putExtra(MainActivity.SEARCH_PRICE, searchPrice);
		intent.putExtra(MainActivity.SEARCH_MINMAX, searchMinmax);
		intent.putExtra(MainActivity.SEARCH_START, searchStart + searchSize);
		intent.putExtra(MainActivity.SEARCH_SIZE, searchSize);

		return intent;
	}

}
