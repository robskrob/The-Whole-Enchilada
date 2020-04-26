chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
  console.log('the request')
  let body = document.querySelector('body')

//  console.log(body);
//  console.log(body.innerText)

  sendResponse({text: body.innerText});
});
