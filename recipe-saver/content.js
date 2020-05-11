chrome.extension.onRequest.addListener(function(request, sender, sendResponse) {
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
    var imageDataArray = Array.from(document.querySelectorAll("[style*='background-image'], img")).reduce(function(acc, imageElement) {
      var imageSource = imageElement.getAttribute('src');
      var backgroundImageMatch = imageElement.style.backgroundImage.match(/url\(["']?([^"']*)["']?\)/);

      if (!/(http(s?)):\/\//i.test(imageSource)) {
        imageSource = "https:" + imageSource;
      }

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
