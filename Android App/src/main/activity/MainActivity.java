package main.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import java.util.ArrayList;
import java.util.List;

public class MainActivity extends Activity
{
	private Spinner spinnerMinmax;
	
	public final static String DEVICE_ID = "com.portmob.DEVICE_ID";
	public final static String SEARCH_COMPANY = "com.portmob.SEARCH_COMPANY";
	public final static String SEARCH_DEVICE = "com.portmob.SEARCH_DEVICE";
	public final static String SEARCH_OS = "com.portmob.SEARCH_OS";
	public final static String SEARCH_PRICE = "com.portmob.SEARCH_PRICE";
	public final static String SEARCH_MINMAX = "com.portmob.SEARCH_MINMAX";
	public final static String SEARCH_START = "com.portmob.SEARCH_START";
	public final static String SEARCH_SIZE = "com.portmob.SEARCH_SIZE";

	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
		
		spinnerMinmax = (Spinner) findViewById(R.id.spinner_minmax);
		List<String> listMinmax = new ArrayList<String>();
		listMinmax.add("Maximum");
		listMinmax.add("Minimum");
		ArrayAdapter<String> dataAdapter = new ArrayAdapter<String>(this,
		android.R.layout.simple_spinner_item, listMinmax);
		dataAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinnerMinmax.setAdapter(dataAdapter);
    }
	
	public void gotoSearch(View view) {
		EditText editText;
		
		// get search parameters
		editText = (EditText) findViewById(R.id.search_company);
		String searchCompany = editText.getText().toString();
		
		editText = (EditText) findViewById(R.id.search_device);
		String searchDevice = editText.getText().toString();
		
		editText = (EditText) findViewById(R.id.search_os);
		String searchOS = editText.getText().toString();
		
		editText = (EditText) findViewById(R.id.search_price);
		String searchPrice = editText.getText().toString();
		
		int searchStart = 0;
		int searchSize = 3;
		
		String searchMinmax = spinnerMinmax.getSelectedItem().toString();
		if (searchMinmax.equals("Maximum")) {
			searchMinmax = "max";
		}
		else {
			searchMinmax = "min";
		}
		
		// 
		Intent intent = new Intent(this, SearchActivity.class);
		intent.putExtra(SEARCH_COMPANY, searchCompany);
		intent.putExtra(SEARCH_DEVICE, searchDevice);
		intent.putExtra(SEARCH_OS, searchOS);
		intent.putExtra(SEARCH_PRICE, searchPrice);
		intent.putExtra(SEARCH_MINMAX, searchMinmax);
		intent.putExtra(SEARCH_START, searchStart);
		intent.putExtra(SEARCH_SIZE, searchSize);
		startActivity(intent);
	}
}
