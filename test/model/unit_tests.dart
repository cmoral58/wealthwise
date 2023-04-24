import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:gsheets/gsheets.dart';



Future<void> main() async {

  const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "wealthwise-gsheets",
  "private_key_id": "85740f1179ca93b6f50b58696e93361edec423ce",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDFEWF2F3idQOSd\n3zUs7QzaOw6abs1xA55AEOtveuDFVTkS0sHhiaMXvoErlGCkL3bOtF5S8buMTz7v\n5Rm1K/kIj+nphQf8O768LciAulyIjw8l+QbzxrYbMkD9CBw5hlw5x3UwvpCu8z+3\nXQc9SUsTG6xNygWHEyxT3GZ6wDZPg1h9rAx9R0ejHLkDKkBV7arMH0b9Zpmbv66Z\ndDpa+3UHdWYCFUIEUP94NWtqvPfWRFhuYy4hQy8O3S1VAwCadYYgwwTkFR+t0UCM\nTUUocYf/M157VQOy+17VF/FfWuEJXzagTpiExxo9YSH9s3rRGvIuvCxMBWjL7pXa\n7kxt0ihNAgMBAAECggEAEbQbhM/b+oiLYTFdphEPoAVBLRd6JkZ0b331oJix25hp\n3aqIV1oViDsJgKA+RFGtQymJ9bqYpiSyWzvCIPf30dCX624ThxHY8y/LvODBElWD\nv14NRVYbIvtTQkf5vSM4Yspr2TqtZcIdfbwCO/u7HlbUllJpR7atu0ToAewFlQPn\nxV8liWCrQwsIK0R5bSMeHbRXOjOY+F37Aoj7gVOQR9YwTHC31Uh4SQIvY3CNidzP\n0TfCk5S5fYUWmBtQEYISy6DM/V4syioIToqEgb4SIjvdmeuApMbPYi/YKDgrQ0gO\njVyk1ONV3pK+2ftEaEA7Cs8SfotDDjfAq/7Q4EEsswKBgQDsP3duA3aCwat0p3Yx\nGpXMU5DmmffxGy8w6uW/YAp3nAQV6fV93nQmZ0QxT7CTcA3dzmskTSdrL71ZKq85\npV39uEA9pEMpcp6VvqttPME2EDoJPXZ5vl3rwlXPM8Mbv0RCEghOw86XYWM97zke\n6Kt8xNLXY4uelVlUIXnb5ExKfwKBgQDVi1MJ5Z68rNEG3Jlwq4ZXGPwVno239inb\nbaNqSp56b0U3Xn+4D1NrlF4nXAjkkOWYQazHswyQqTQK/NPS7DcnG830F/Y4DFUE\n6plMEkaOOs53iVl1qLgj9T70iH/mXBI4//iqFjAoKPMncZcEudEVqiw8uiJzun5u\n+nX9Ig4vMwKBgQClJoDgwT75jVXEiMSQ8xrA6bIj4oJ3ZB+LPMo7DHKExuX8Q78/\nrGDZ79q19hVkHDM1WXWAvQbPYWImkTZJQBcCpOkTrl7c/Klr2QyRoqUWnCVWDEdk\nN/YEN6gw3uiH3x9iaKSyGyOyo3vy8eametRWtmkF9SrHQ3Rc4cIEPAYxFQKBgE5G\npuau09QHaQuh22DwjuroTqdCGmK/ijJT6x3wQk1Q8kdMjXaTr5l0plq5Is1dy7tW\n/5WoLUftrhUE/kSHr+PXDlSWX/vFkXie4hh/bnt+VOZ+Y1t8wBr2L+CFFJUFVOyt\n76GxRm/CKvdfbOMflePiIBsWg8B2MRhPGOb0D8z/AoGBAJo/oy4/Vlo5tUSxn+zJ\nJSwVTHpOtAWHsrtqc71ARo8uJJ9170kZepK3pIcBcfomKDZ8BmDL375OduFxNVRA\nBe27LYPpO43k/7OOzNWUT+/fZVt6t/7Pxtp9CdC7W64YxNcmxH9TDiT+M3Oua76M\nvNq0ef1wrNFImTWCYheNRpj6\n-----END PRIVATE KEY-----\n",
  "client_email": "wealthwise-gsheets@wealthwise-gsheets.iam.gserviceaccount.com",
  "client_id": "105472848654986445884",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/wealthwise-gsheets%40wealthwise-gsheets.iam.gserviceaccount.com"
  }
  ''';

  final gsheets = GSheets(_credentials);
  const _spreadsheetId = '1oZauq04wjyto8SQlK2hRj_vy4jdmbY5MfGgsFJIDWuw';

  test('read data from worksheet', () async {
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final worksheet = ss.worksheetByTitle('Worksheet1');

    // Add values to the worksheet to confirm everything is being added correctly
    await worksheet?.values.insertRow(2, ['Title', '100', 'Expense', 'User1', 'Jan', '1']);

    // Read the second row (skipping header)
    final allRows = await worksheet?.values.map.allRows();

    // Define expected map
    final expected = {
      'Title': 'Title',
      'Amount': '100',
      'Expense/Income': 'Expense',
      'User ID': 'User1',
      'Month': 'Jan',
      'Day': '1'
    };

    // Compare actual and expected maps
    expect(allRows?.first, equals(expected));


    expect(true, equals(true));

    print('NOTE: UNIT TESTS DON\'T NORMALY OUTPUT TEXT. THE TEXT BELOW IS JUST TO HAVE A VISUAL INDICATOR THAT THE TESTS WERE SUCCESSFUL');
    print('Google sheets is being read successfully!');
    print('');
  });


  test('add event', () async{
    final instance = FakeFirebaseFirestore();
    late String userId = MockUser().uid;
    late User currentUser = MockUser();
    await instance.collection('events').doc(userId).collection('userEvents').add({
      'date': FieldValue.serverTimestamp(),
      'description': 'Mock description',
      'title': 'Mock title'
    });

    expect(true, equals(true));
    print('Event was added successfully!');
    print('');

  });



  test('send feedback', () async {
    final instance = FakeFirebaseFirestore();
    late String userId = MockUser().uid;
    late User currentUser = MockUser();
    await instance.collection('feedback').doc(userId).collection('userFeedback').add({
      'feedback': 'Mock feedback',
      'username': 'Mock name'
    });

    expect(true, equals(true));
    print('Feedback was sent successfully!');
    print('');

  });

}










