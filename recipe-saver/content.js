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
    // document.querySelectorAll("[style*='background-image']")[6].style.backgroundImage.match(/url\(["']?([^"']*)["']?\)/)[1]
    //
    var imageDataArray = Array.from(document.querySelectorAll("[style*='background-image'], img")).reduce(function(acc, imageElement) {
      var imageSource = imageElement.getAttribute('src');
      var backgroundImageMatch = imageElement.style.backgroundImage.match(/url\(["']?([^"']*)["']?\)/);

      if (imageSource && imageSource.length > 0) {
        acc.push({
          source: imageSource,
          alt: imageElement.getAttribute('alt')
        })
      } else if (backgroundImageMatch) {
        acc.push({
          source: backgroundImageMatch[1],
          alt: "background image"
        })
      }

      return acc;
    }, []);

    sendResponse({
      imageDataArray
    });
  }
});
