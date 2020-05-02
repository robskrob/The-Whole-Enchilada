chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
  console.log('request', request);
  console.log('sender', sender);
  if (request.action === 'getInnerHTML') {
    let body = document.querySelector('body');

    sendResponse({
      content: body.innerText,
      host_origin: window.location.host,
      name: window.location.host + window.location.pathname,
      pathname: window.location.pathname
    });
  }

  if (request.action === 'getImageElements') {
    let imageDataArray = Array.from(document.querySelectorAll('img')).map(function(imageElement) {
      return {
        source: imageElement.getAttribute('src'),
        alt: imageElement.getAttribute('alt')
      }
    })

    sendResponse({
      imageDataArray
    });
  }
});
