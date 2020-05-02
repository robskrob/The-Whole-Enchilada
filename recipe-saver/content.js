chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
  console.log('the request')
  let body = document.querySelector('body')

//  console.log(body);
//  console.log(body.innerText)

  sendResponse({
    content: body.innerText,
    host_origin: window.location.host,
    name: window.location.host + window.location.pathname,
    pathname: window.location.pathname
  });
});
