function hello() {
  console.log('hello!!');

  var query = { active: true, currentWindow: true };

  function callback(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array
    console.log(currentTab); // also has properties like currentTab.id

    chrome.tabs.sendRequest(currentTab.id, {action: "getDOM"}, function(response) {

      console.log('TEXT FROM ACTIVE TAB', response.content);

      $.ajax({
        method: 'POST',
        url: "https://282a1084.ngrok.io/api/v1/web_recipes",
        data: {
          content: response.content,
          host_origin: response.host_origin,
          name: response.name,
          pathname: response.pathname
        }
      }).done(function( data ) {
        console.log('RESPONSE FROM THE WHOLE ENCHILADA', data)
      });
    });

//    $.ajax({
//      url: "https://google.com"
//    }).done(function( data ) {
//      console.log(data)
//    });
  }

  chrome.tabs.query(query, callback);

}

document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('#clickme').addEventListener('click', hello);
});
