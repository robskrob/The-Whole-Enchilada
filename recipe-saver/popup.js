function hello() {
  console.log('hello!!');

  var query = { active: true, currentWindow: true };

  function callback(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array
    console.log(currentTab); // also has properties like currentTab.id

    chrome.tabs.sendRequest(currentTab.id, {action: "getDOM"}, function(response) {

      console.log('TEXT FROM ACTIVE TAB', response.text);

      $.ajax({
        url: "https://google.com"
      }).done(function( data ) {
        console.log('RESPONSE FROM GOOGLE', data)
      });
    });
  }

  chrome.tabs.query(query, callback);

}

document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('#clickme').addEventListener('click', hello);
});
