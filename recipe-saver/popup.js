function findOrCreateRecipe() {

  function postRecipeTextCallback(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array

    chrome.tabs.sendRequest(currentTab.id, {action: "getInnerHTML"}, function(response) {
      $.ajax({
        method: 'POST',
        url: "https://85ebc4cd.ngrok.io/api/v1/web_recipes",
        data: {
          content: response.content,
          host_origin: response.host_origin,
          name: response.name,
          pathname: response.pathname
        }
      }).done(function( data ) {
        console.log('RESPONSE FROM THE WHOLE ENCHILADA', data);
        var getImagesButtonElement = document.querySelector('.WholeEnchiladaRecipes__get-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
        var importButtonElement = document.querySelector('.WholeEnchiladaRecipes__import-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
        var saveButtonElement = document.querySelector('.WholeEnchiladaRecipes__save-recipe-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

        importButtonElement.setAttribute('data-recipe-id', data.recipe.id);

        saveButtonElement.classList.add('WholeEnchiladaRecipes_hide--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
        getImagesButtonElement.classList.add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
      });
    });
  }

  chrome.tabs.query({active: true, currentWindow: true}, postRecipeTextCallback);

}

function queryImages() {
  function queryImagesFromActiveTabCallback(tabs) {
    var currentTab = tabs[0]; // there will be only one in this array

    chrome.tabs.sendRequest(currentTab.id, {action: "getImageElements"}, function(response) {
      var imagesSectionElement = document.querySelector('.WholeEnchiladaRecipes_images-section--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // make popup html wider
      document.querySelector('#the-whole-enchilada-recipe-saver--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU')
        .setAttribute('style', 'width: 300px;');

      // hide get images button
      let getImagesButtonElement = document
        .querySelector('.WholeEnchiladaRecipes__get-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // hide get images button
      getImagesButtonElement
        .classList
        .remove('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // hide get images button
      getImagesButtonElement
        .classList
        .add('WholeEnchiladaRecipes_hide--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // show image selection instructions
      document.querySelector('.WholeEnchiladaRecipes_images-hero--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp ')
        .classList
        .add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // insert images for selection into popup html
      response.imageDataArray.forEach(function(imageData) {
        var imageElementString = "<img src='" +
          imageData.source +
          "' alt='" + imageData.alt + "' class='image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp'>";

        imagesSectionElement.insertAdjacentHTML('afterbegin', imageElementString);
      })

      // add selection event to images to add border
      Array.from(document.querySelectorAll('img.image--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')).forEach(function(imageElement) {
        imageElement.addEventListener('click', function(event) {
          event.preventDefault();
          event.currentTarget.classList.toggle('selected--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');
        });
      });

      let importImagesButtonElement = document
        .querySelector('.WholeEnchiladaRecipes__import-images-button--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      // show import image button
      importImagesButtonElement.classList.add('WholeEnchiladaRecipes_reveal--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp');

      importImagesButtonElement
        .addEventListener('click', function(event) {
          event.preventDefault();
          var recipeId = event.currentTarget.dataset.recipeId;

          var imageDataArray = Array.from(document.querySelectorAll('.selected--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaUp')).map(function(selectedImageElement) {
            return {
              source: selectedImageElement.getAttribute('src'),
              alt: selectedImageElement.getAttribute('alt')
            };
          })

          if (imageDataArray.length) {
            $.ajax({
              method: 'POST',
              url: "https://85ebc4cd.ngrok.io/api/v1/recipes/" + recipeId + "/images",
              data: {
                imageDataArray: JSON.stringify(imageDataArray)
              }
            }).done(function( data ) {
              console.log('RESPONSE FROM THE WHOLE ENCHILADA', data);
              alert('Images saved!')
            });
          }
        });
    });
  }

  chrome.tabs.query({active: true, currentWindow: true}, queryImagesFromActiveTabCallback);
}


document.addEventListener("DOMContentLoaded", function(event) {
  document.querySelector('#save-recipe--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', findOrCreateRecipe);
  document.querySelector('#get-images--KZzQjJcI2kdN0Qnn7X7AgyoO8W6VBwuOPIcyztpKBaU').addEventListener('click', queryImages);
});
