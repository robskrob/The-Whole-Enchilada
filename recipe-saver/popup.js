function findOrCreateRecipe() {

  function postRecipeTextCallback(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array
    console.log(currentTab); // also has properties like currentTab.id

    chrome.tabs.sendRequest(currentTab.id, {action: "getInnerHTML"}, function(response) {
      console.log('Response from active  tab', response);
//      console.log('TEXT FROM ACTIVE TAB', response.content);

//      $.ajax({
//        method: 'POST',
//        url: "https://c03cc354.ngrok.io/api/v1/web_recipes",
//        data: {
//          content: response.content,
//          host_origin: response.host_origin,
//          name: response.name,
//          pathname: response.pathname
//        }
//      }).done(function( data ) {
//        console.log('RESPONSE FROM THE WHOLE ENCHILADA', data)
//      });
    });
  }

  chrome.tabs.query({active: true, currentWindow: true}, postRecipeTextCallback);

}

function queryImages() {
  function queryImagesFromActiveTab(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array
    console.log(currentTab); // also has properties like currentTab.id

    chrome.tabs.sendRequest(currentTab.id, {action: "getImageElements"}, function(response) {
      console.log('image elements', response);
      var imagesSectionElement = document.querySelector('.WholeEnchiladaRecipes_images-section--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')

      response.imageDataArray.forEach(function(imageData) {
        var imageElementString = "<img src='" +
          imageData.source +
          "' alt='" + imageData.alt + "' class='image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp'>";

        imagesSectionElement.insertAdjacentHTML('afterbegin', imageElementString);
      })

//      Array.from(document.querySelectorAll('img.image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')).forEach(function(imageElement) {
//        imageElement.classList.add('')
//      })
    });
  }

  chrome.tabs.query({active: true, currentWindow: true}, queryImagesFromActiveTab);
}


document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('#clickme').addEventListener('click', findOrCreateRecipe);
  document.querySelector('#get-images').addEventListener('click', queryImages);
});
