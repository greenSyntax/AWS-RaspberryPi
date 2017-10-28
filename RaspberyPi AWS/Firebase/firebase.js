// Require
var firebase = require('firebase');

// Initialize
var config = {
    apiKey: "AIzaSyDhfPnqMy-2BUO47LXb0XV3Xk_zyF5kYOo",
    authDomain: "raspberrypi-5a0e6.firebaseapp.com",
    databaseURL: "https://raspberrypi-5a0e6.firebaseio.com",
    projectId: "raspberrypi-5a0e6",
    storageBucket: "raspberrypi-5a0e6.appspot.com",
    messagingSenderId: "317632247768"
  };


firebase.initializeApp(config);

// Database
var database = firebase.app().database();
var reference = database.ref('messages');

//Save Value
var data = {firstName : "Abhishek",
     	    lastName : "Kumar"	};

//Push
reference.push(data);


